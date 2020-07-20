Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF8226CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgGTQ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 12:59:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:34689 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgGTQ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:59:42 -0400
IronPort-SDR: X5i7G/3fOU8XWBUgB0C894DnURMjAwSfyJqHTm8RgmmcgXZAY6e4HLlVf0LOvXeYKgrt4DftkH
 RRw/BZ4qZzYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="168102499"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="168102499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 09:59:41 -0700
IronPort-SDR: pDzSBFM4yJH1tXx4Kp7X64fNGS8OeidMosNuhZ4pmB+IxdQ1QIUfyNyWorsyqe1LEcQzrKgWS6
 NlhiyE6EaGaw==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="392088999"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.123.246])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 09:59:38 -0700
Message-ID: <23893338061f2066693f4eb18c8d059d59327952.camel@linux.intel.com>
Subject: Re: [PATCH v4 09/10] kallsyms: Hide layout
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>
Date:   Mon, 20 Jul 2020 09:59:35 -0700
In-Reply-To: <202007191815.D39859C@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
         <20200717170008.5949-10-kristen@linux.intel.com>
         <202007191815.D39859C@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-19 at 18:25 -0700, Kees Cook wrote:
> On Fri, Jul 17, 2020 at 10:00:06AM -0700, Kristen Carlson Accardi
> wrote:
> > This patch makes /proc/kallsyms display in a random order, rather
> > than sorted by address in order to hide the newly randomized
> > address
> > layout.
> 
> Ah! Much nicer. Is there any reason not to just do this
> unconditionally,
> regardless of FGKASLR? It's a smallish dynamic allocation, and
> displaying kallsyms is hardly fast-path...

My only concern would be whether or not there are scripts out there
which assume the list would be ordered. If someone chooses to enable
CONFIG_FG_KASLR, I think that it is reasonable to break those scripts.
On the flip side, I don't know why it needs to come out of
/proc/kallsyms in order, you can always just sort it after the fact if
you need it sorted. It would make it more maintainable to not special
case this. Hopefully a maintainer will comment on their preference.
Another thing I do in this patch is continue to use the existing sorted
by address functions if you are root. I didn't know if this was
neccessary - it'd be nice if we could just do it the same way all the
time. But I need some guidance here.

> 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  kernel/kallsyms.c | 163
> > +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 162 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index bb14e64f62a4..45d147f7f10e 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -446,6 +446,12 @@ struct kallsym_iter {
> >  	int show_value;
> >  };
> >  
> > +struct kallsyms_shuffled_iter {
> > +	struct kallsym_iter iter;
> > +	loff_t total_syms;
> > > 
> > > (I need to go read how kallsyms doesn't miscount in general when
> > the
> > > symbol table changes out from under it...)
> > > 
> > > 
> > +	loff_t shuffled_index[];
> > +};
> > +
> >  int __weak arch_get_kallsym(unsigned int symnum, unsigned long
> > *value,
> >  			    char *type, char *name)
> >  {
> > @@ -661,7 +667,7 @@ bool kallsyms_show_value(const struct cred
> > *cred)
> >  	}
> >  }
> >  
> > -static int kallsyms_open(struct inode *inode, struct file *file)
> > +static int __kallsyms_open(struct inode *inode, struct file *file)
> >  {
> >  	/*
> >  	 * We keep iterator in m->private, since normal case is to
> > @@ -682,6 +688,161 @@ static int kallsyms_open(struct inode *inode,
> > struct file *file)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * When function granular kaslr is enabled, we need to print out
> > the symbols
> > + * at random so we don't reveal the new layout.
> > + */
> > +#if defined(CONFIG_FG_KASLR)
> > +static int update_random_pos(struct kallsyms_shuffled_iter
> > *s_iter,
> > +			     loff_t pos, loff_t *new_pos)
> > +{
> > +	loff_t new;
> > +
> > +	if (pos >= s_iter->total_syms)
> > +		return 0;
> > +
> > +	new = s_iter->shuffled_index[pos];
> > +
> > +	/*
> > +	 * normally this would be done as part of update_iter, however,
> > +	 * we want to avoid triggering this in the event that new is
> > +	 * zero since we don't want to blow away our pos end
> > indicators.
> > +	 */
> > +	if (new == 0) {
> > +		s_iter->iter.name[0] = '\0';
> > +		s_iter->iter.nameoff = get_symbol_offset(new);
> > +		s_iter->iter.pos = new;
> > +	}
> > +
> > +	*new_pos = new;
> > +	return 1;
> > +}
> > +
> > +static void *shuffled_start(struct seq_file *m, loff_t *pos)
> > +{
> > +	struct kallsyms_shuffled_iter *s_iter = m->private;
> > +	loff_t new_pos;
> > +
> > +	if (!update_random_pos(s_iter, *pos, &new_pos))
> > +		return NULL;
> > +
> > +	return s_start(m, &new_pos);
> > +}
> > +
> > +static void *shuffled_next(struct seq_file *m, void *p, loff_t
> > *pos)
> > +{
> > +	struct kallsyms_shuffled_iter *s_iter = m->private;
> > +	loff_t new_pos;
> > +
> > +	(*pos)++;
> > +
> > +	if (!update_random_pos(s_iter, *pos, &new_pos))
> > +		return NULL;
> > +
> > +	if (!update_iter(m->private, new_pos))
> > +		return NULL;
> > +
> > +	return p;
> > +}
> > +
> > +/*
> > + * shuffle_index_list()
> > + * Use a Fisher Yates algorithm to shuffle a list of text
> > sections.
> > + */
> > +static void shuffle_index_list(loff_t *indexes, loff_t size)
> > +{
> > +	int i;
> > +	unsigned int j;
> > +	loff_t temp;
> > +
> > +	for (i = size - 1; i > 0; i--) {
> > +		/* pick a random index from 0 to i */
> > +		get_random_bytes(&j, sizeof(j));
> > +		j = j % (i + 1);
> > +
> > +		temp = indexes[i];
> > +		indexes[i] = indexes[j];
> > +		indexes[j] = temp;
> > +	}
> > +}
> > +
> > +static const struct seq_operations kallsyms_shuffled_op = {
> > +	.start = shuffled_start,
> > +	.next = shuffled_next,
> > +	.stop = s_stop,
> > +	.show = s_show
> > +};
> > +
> > +static int kallsyms_random_open(struct inode *inode, struct file
> > *file)
> > +{
> > +	loff_t pos;
> > +	struct kallsyms_shuffled_iter *shuffled_iter;
> > +	struct kallsym_iter iter;
> > +	bool show_value;
> > +
> > +	/*
> > +	 * If privileged, go ahead and use the normal algorithm for
> > +	 * displaying symbols
> > +	 */
> > +	show_value = kallsyms_show_value(file->f_cred);
> > +	if (show_value)
> > +		return __kallsyms_open(inode, file);
> > +
> > +	/*
> > +	 * we need to figure out how many extra symbols there are
> > +	 * to print out past kallsyms_num_syms
> > +	 */
> > +	pos = kallsyms_num_syms;
> > +	reset_iter(&iter, 0);
> > +	do {
> > +		if (!update_iter(&iter, pos))
> > +			break;
> > +		pos++;
> > +	} while (1);
> 
> Can this be tracked separately instead of needing to search for it
> every
> time? (Looks like it's modules and ftrace? Could they each have a
> *_num_sysms?)

It could, but I'd probably have to make more changes to those
subsystems to keep this information there than I would to just do this
search here. Because we start search at the end of the kernel core
symbols, I don't think this search takes too many cycles to complete.
On my system running a standard distro config the number of module and
bpf symbols is not all that many, especially compared to the kernel
core symbols.


