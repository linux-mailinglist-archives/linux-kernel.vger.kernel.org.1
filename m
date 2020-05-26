Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655401B1370
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgDTRq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 13:46:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:45497 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:46:26 -0400
IronPort-SDR: 6MI0VYnp3vK7GYU5XbV+6joWLUJgJB3Zd5BLWHu2XFzLOBMOqoHIjccCQVhm92FBJmk5le5vfC
 CZDe0bUFAosA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:46:23 -0700
IronPort-SDR: RfJ4A7JXxNGXvqxm7c+sec8ydcwdtqIaHZnIRedDaUSt7OvLBf29y5BX3dfPCuGeh+g9zjr3VQ
 e6et6oxlIvCw==
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="401908560"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.34.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:46:22 -0700
Message-ID: <ee16c27406592ffa6c29e00b42fa1da6722fb7ec.camel@linux.intel.com>
Subject: Re: [PATCH 8/9] kallsyms: hide layout
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, arjan@linux.intel.com, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com
Date:   Mon, 20 Apr 2020 10:46:20 -0700
In-Reply-To: <CAMj1kXGyQbdmeAwVBy5YPGKeksNq0KkBe-wmZZG=xkGY4Ds0Rg@mail.gmail.com>
References: <20200415210452.27436-1-kristen@linux.intel.com>
         <20200415210452.27436-9-kristen@linux.intel.com>
         <CAMj1kXGyQbdmeAwVBy5YPGKeksNq0KkBe-wmZZG=xkGY4Ds0Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-20 at 13:58 +0200, Ard Biesheuvel wrote:
> On Wed, 15 Apr 2020 at 23:06, Kristen Carlson Accardi
> <kristen@linux.intel.com> wrote:
> > To support finer grained kaslr (fgkaslr), we need to hide our
> > sorted
> > list of symbols, since this will give away our new layout.
> > This patch makes /proc/kallsyms only visible to priviledged users.
> > 
> 
> Does it?

Oops, I forgot to update my commit message since I changed algorithms.
Thanks for catching that. I'll fix it in the next version.

> 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> >  kernel/kallsyms.c | 138
> > +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 137 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 16c8c605f4b0..861972b6a879 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/filter.h>
> >  #include <linux/ftrace.h>
> >  #include <linux/compiler.h>
> > +#include <linux/list_sort.h>
> > 
> >  /*
> >   * These will be re-linked against their real values
> > @@ -446,6 +447,11 @@ struct kallsym_iter {
> >         int show_value;
> >  };
> > 
> > +struct kallsyms_iter_list {
> > +       struct kallsym_iter iter;
> > +       struct list_head next;
> > +};
> > +
> >  int __weak arch_get_kallsym(unsigned int symnum, unsigned long
> > *value,
> >                             char *type, char *name)
> >  {
> > @@ -660,6 +666,121 @@ int kallsyms_show_value(void)
> >         }
> >  }
> > 
> > +static int sorted_show(struct seq_file *m, void *p)
> > +{
> > +       struct list_head *list = m->private;
> > +       struct kallsyms_iter_list *iter;
> > +       int rc;
> > +
> > +       if (list_empty(list))
> > +               return 0;
> > +
> > +       iter = list_first_entry(list, struct kallsyms_iter_list,
> > next);
> > +
> > +       m->private = iter;
> > +       rc = s_show(m, p);
> > +       m->private = list;
> > +
> > +       list_del(&iter->next);
> > +       kfree(iter);
> > +
> > +       return rc;
> > +}
> > +
> > +static void *sorted_start(struct seq_file *m, loff_t *pos)
> > +{
> > +       return m->private;
> > +}
> > +
> > +static void *sorted_next(struct seq_file *m, void *p, loff_t *pos)
> > +{
> > +       struct list_head *list = m->private;
> > +
> > +       (*pos)++;
> > +
> > +       if (list_empty(list))
> > +               return NULL;
> > +
> > +       return p;
> > +}
> > +
> > +static const struct seq_operations kallsyms_sorted_op = {
> > +       .start = sorted_start,
> > +       .next = sorted_next,
> > +       .stop = s_stop,
> > +       .show = sorted_show
> > +};
> > +
> > +static int kallsyms_list_cmp(void *priv, struct list_head *a,
> > +                               struct list_head *b)
> > +{
> > +       struct kallsyms_iter_list *iter_a, *iter_b;
> > +
> > +       iter_a = list_entry(a, struct kallsyms_iter_list, next);
> > +       iter_b = list_entry(b, struct kallsyms_iter_list, next);
> > +
> > +       return strcmp(iter_a->iter.name, iter_b->iter.name);
> > +}
> > +
> > +int get_all_symbol_name(void *data, const char *name, struct
> > module *mod,
> > +                       unsigned long addr)
> > +{
> > +       unsigned long sym_pos;
> > +       struct kallsyms_iter_list *node, *last;
> > +       struct list_head *head = (struct list_head *)data;
> > +
> > +       node = kmalloc(sizeof(*node), GFP_KERNEL);
> > +       if (!node)
> > +               return -ENOMEM;
> > +
> > +       if (list_empty(head)) {
> > +               sym_pos = 0;
> > +               memset(node, 0, sizeof(*node));
> > +               reset_iter(&node->iter, 0);
> > +               node->iter.show_value = kallsyms_show_value();
> > +       } else {
> > +               last = list_first_entry(head, struct
> > kallsyms_iter_list, next);
> > +               memcpy(node, last, sizeof(*node));
> > +               sym_pos = last->iter.pos;
> > +       }
> > +
> > +       INIT_LIST_HEAD(&node->next);
> > +       list_add(&node->next, head);
> > +
> > +       /*
> > +        * update_iter returns false when at end of file
> > +        * which in this case we don't care about and can
> > +        * safely ignore. update_iter() will increment
> > +        * the value of iter->pos, for ksymbol_core.
> > +        */
> > +       if (sym_pos >= kallsyms_num_syms)
> > +               sym_pos++;
> > +
> > +       (void) update_iter(&node->iter, sym_pos);
> > +
> > +       return 0;
> > +}
> > +
> > +static int kallsyms_sorted_open(struct inode *inode, struct file
> > *file)
> > +{
> > +       int ret;
> > +       struct list_head *list;
> > +
> > +       list = __seq_open_private(file, &kallsyms_sorted_op,
> > sizeof(*list));
> > +       if (!list)
> > +               return -ENOMEM;
> > +
> > +       INIT_LIST_HEAD(list);
> > +
> > +       ret = kallsyms_on_each_symbol(get_all_symbol_name, list);
> > +       if (ret != 0)
> > +               return ret;
> > +
> > +       list_sort(NULL, list, kallsyms_list_cmp);
> > +
> 
> Could we do the sort at init time rather than open time

I could do this, but module symbols would not be included, and also we
would have to maintain a separate symbol list in memory forever since
we have to keep the list sorted by address for bsearch. So, it does
increase memory consumption vs. just allocating space, sorting, and
then deallocating. I personally feel it's a better trade off to sort at
open.

> 
> > +       return 0;
> > +}
> > +
> >  static int kallsyms_open(struct inode *inode, struct file *file)
> >  {
> >         /*
> > @@ -704,9 +825,24 @@ static const struct proc_ops kallsyms_proc_ops
> > = {
> >         .proc_release   = seq_release_private,
> >  };
> > 
> > +static const struct proc_ops kallsyms_sorted_proc_ops = {
> > +       .proc_open = kallsyms_sorted_open,
> > +       .proc_read = seq_read,
> > +       .proc_lseek = seq_lseek,
> > +       .proc_release = seq_release_private,
> > +};
> > +
> >  static int __init kallsyms_init(void)
> >  {
> > -       proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > +       /*
> > +        * When fine grained kaslr is enabled, we need to
> > +        * print out the symbols sorted by name rather than by
> > +        * by address, because this reveals the randomization
> > order.
> > +        */
> > +       if (!IS_ENABLED(CONFIG_FG_KASLR))
> > +               proc_create("kallsyms", 0444, NULL,
> > &kallsyms_proc_ops);
> > +       else
> > +               proc_create("kallsyms", 0444, NULL,
> > &kallsyms_sorted_proc_ops);
> 
> Can we just switch to the sorted version unconditionally instead? Or
> is the output order of /proc/kallsyms considered kernel ABI?

I didn't know the answer to this question, which is why to be safe I
maintained the existing behavior when my feature is not enabled.

> 

