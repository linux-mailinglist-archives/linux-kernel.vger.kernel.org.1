Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F408264928
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgIJPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgIJPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:52:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2044CC06138F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:43:05 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so6543069qkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXlg+o4nRCs+Cav1/tTr/Lfjszvh76b6sUfjxZvNF0M=;
        b=UmMReOLTse0CeXLfAeJIVI8mwSt0+EIBMlWIe9ErqMp6LCMkEeVPmGNl8lKEy6w1Vl
         p2iuIpPfBdbHFiqPZ9WebBs96CqTyMAiVhBI3/c+q17RH3cMbe9bSRTPmTlyihbUzwCz
         canvTbCZrTuM3MdjS/FiVxyan2+++ZAHVobwJ7cJLkFYOV6HeUMKnLdJMdDbL8GsdxhK
         ZHiIszaI6oTzlaeJ/S3EMO/mNDMKMJHu+a7hbWKWVOIY/85DC80VTuFyAI6DTmH06UP7
         LQCyn33Vw2avaPvz9Q4MOTRKCbn6wu30a8XXO2IACzt5znM0Djq67b+BW4U1//vJ2eFh
         yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXlg+o4nRCs+Cav1/tTr/Lfjszvh76b6sUfjxZvNF0M=;
        b=ikYNjwu8VBPPx2lihlqXbatMt97ZFVNC7V8WkFLRZl8NIKJv7jT6M85Y9awOnGRGRh
         MOdeA0otZDfPtoSj48a9qeLVLf8f6eLHS4XWeV6JYX+5YO5rGBjbJ6fldchTv9mjLUot
         l1ikLRdd2RACOV5ShsAos02Jfyk0qsoz4u3Bsgnw7s48e4qZEPNzSSlZSMzqrPxRB5zh
         +dYFZ87spL2U2h5dc1zDXVrXU2Q8uf5yqKkcnnyM/zuiNDNLwKI+1hPp7UGLZeU64InY
         /X/uA+qcnTm+uFIlE2z+I3UgFtw6XfQSynKeecvtKFryTTNYrUG8ury9ukYDYRUjA6ae
         W8CQ==
X-Gm-Message-State: AOAM530KZFLbzyk+B/DvbS/5M72vxaBmq+g7O0gTh8x0wEERl3JjAEN6
        kLZzzY9G0XzQKpQxHBJda6nb372WHcZAWm3BdmSXcg==
X-Google-Smtp-Source: ABdhPJxNBfbmbyQZL/f/lMNSZK4sXylN2Co7lc0a4/wcnxZFWjyXi54rlDmgGmUTYjStvzrbYYWt7+1cbMB+b14moD0=
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr8706256qke.250.1599752584211;
 Thu, 10 Sep 2020 08:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-2-elver@google.com>
In-Reply-To: <20200907134055.2878499-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Sep 2020 17:42:52 +0200
Message-ID: <CACT4Y+bfp2ch2KbSMkUd3142aA4p2CiMOmdXrr0-muu6bQ5xXg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:

> +       meta->addr = metadata_to_pageaddr(meta);
> +       /* Unprotect if we're reusing this page. */
> +       if (meta->state == KFENCE_OBJECT_FREED)
> +               kfence_unprotect(meta->addr);
> +
> +       /* Calculate address for this allocation. */
> +       if (right)
> +               meta->addr += PAGE_SIZE - size;
> +       meta->addr = ALIGN_DOWN(meta->addr, cache->align);

I would move this ALIGN_DOWN under the (right) if.
Do I understand it correctly that it will work, but we expect it to do
nothing for !right? If cache align is >PAGE_SIZE, nothing good will
happen anyway, right?
The previous 2 lines look like part of the same calculation -- "figure
out the addr for the right case".


> +       /* Update remaining metadata. */
> +       metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED);
> +       /* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
> +       WRITE_ONCE(meta->cache, cache);
> +       meta->size = right ? -size : size;
> +       for_each_canary(meta, set_canary_byte);
> +       virt_to_page(meta->addr)->slab_cache = cache;
> +
> +       raw_spin_unlock_irqrestore(&meta->lock, flags);
> +
> +       /* Memory initialization. */
> +
> +       /*
> +        * We check slab_want_init_on_alloc() ourselves, rather than letting
> +        * SL*B do the initialization, as otherwise we might overwrite KFENCE's
> +        * redzone.
> +        */
> +       addr = (void *)meta->addr;
> +       if (unlikely(slab_want_init_on_alloc(gfp, cache)))
> +               memzero_explicit(addr, size);
> +       if (cache->ctor)
> +               cache->ctor(addr);
> +
> +       if (CONFIG_KFENCE_FAULT_INJECTION && !prandom_u32_max(CONFIG_KFENCE_FAULT_INJECTION))
> +               kfence_protect(meta->addr); /* Random "faults" by protecting the object. */
> +
> +       atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCATED]);
> +       atomic_long_inc(&counters-F[KFENCE_COUNTER_ALLOCS]);
> +       return addr;
> +}
> +
> +static void kfence_guarded_free(void *addr, struct kfence_metadata *meta)
> +{
> +       struct kcsan_scoped_access assert_page_exclusive;
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&meta->lock, flags);
> +
> +       if (meta->state != KFENCE_OBJECT_ALLOCATED || meta->addr != (unsigned long)addr) {
> +               /* Invalid or double-free, bail out. */
> +               atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> +               kfence_report_error((unsigned long)addr, meta, KFENCE_ERROR_INVALID_FREE);
> +               raw_spin_unlock_irqrestore(&meta->lock, flags);
> +               return;
> +       }
> +
> +       /* Detect racy use-after-free, or incorrect reallocation of this page by KFENCE. */
> +       kcsan_begin_scoped_access((void *)ALIGN_DOWN((unsigned long)addr, PAGE_SIZE), PAGE_SIZE,
> +                                 KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT,
> +                                 &assert_page_exclusive);
> +
> +       if (CONFIG_KFENCE_FAULT_INJECTION)
> +               kfence_unprotect((unsigned long)addr); /* To check canary bytes. */
> +
> +       /* Restore page protection if there was an OOB access. */
> +       if (meta->unprotected_page) {
> +               kfence_protect(meta->unprotected_page);
> +               meta->unprotected_page = 0;
> +       }
> +
> +       /* Check canary bytes for memory corruption. */
> +       for_each_canary(meta, check_canary_byte);
> +
> +       /*
> +        * Clear memory if init-on-free is set. While we protect the page, the
> +        * data is still there, and after a use-after-free is detected, we
> +        * unprotect the page, so the data is still accessible.
> +        */
> +       if (unlikely(slab_want_init_on_free(meta->cache)))
> +               memzero_explicit(addr, abs(meta->size));
> +
> +       /* Mark the object as freed. */
> +       metadata_update_state(meta, KFENCE_OBJECT_FREED);
> +
> +       raw_spin_unlock_irqrestore(&meta->lock, flags);
> +
> +       /* Protect to detect use-after-frees. */
> +       kfence_protect((unsigned long)addr);
> +
> +       /* Add it to the tail of the freelist for reuse. */
> +       raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> +       KFENCE_WARN_ON(!list_empty(&meta->list));
> +       list_add_tail(&meta->list, &kfence_freelist);
> +       kcsan_end_scoped_access(&assert_page_exclusive);
> +       raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> +
> +       atomic_long_dec(&counters[KFENCE_COUNTER_ALLOCATED]);
> +       atomic_long_inc(&counters[KFENCE_COUNTER_FREES]);
> +}
> +
> +static void rcu_guarded_free(struct rcu_head *h)
> +{
> +       struct kfence_metadata *meta = container_of(h, struct kfence_metadata, rcu_head);
> +
> +       kfence_guarded_free((void *)meta->addr, meta);
> +}
> +
> +static bool __init kfence_initialize_pool(void)
> +{
> +       unsigned long addr;
> +       struct page *pages;
> +       int i;
> +
> +       if (!arch_kfence_initialize_pool())
> +               return false;
> +
> +       addr = (unsigned long)__kfence_pool;
> +       pages = virt_to_page(addr);
> +
> +       /*
> +        * Set up non-redzone pages: they must have PG_slab set, to avoid
> +        * freeing these as real pages.
> +        *
> +        * We also want to avoid inserting kfence_free() in the kfree()
> +        * fast-path in SLUB, and therefore need to ensure kfree() correctly
> +        * enters __slab_free() slow-path.
> +        */
> +       for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> +               if (!i || (i % 2))
> +                       continue;
> +
> +               __SetPageSlab(&pages[i]);
> +       }
> +
> +       /*
> +        * Protect the first 2 pages. The first page is mostly unnecessary, and
> +        * merely serves as an extended guard page. However, adding one
> +        * additional page in the beginning gives us an even number of pages,
> +        * which simplifies the mapping of address to metadata index.
> +        */
> +       for (i = 0; i < 2; i++) {
> +               if (unlikely(!kfence_protect(addr)))
> +                       return false;
> +
> +               addr += PAGE_SIZE;
> +       }
> +
> +       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +               struct kfence_metadata *meta = &kfence_metadata[i];
> +
> +               /* Initialize metadata. */
> +               INIT_LIST_HEAD(&meta->list);
> +               raw_spin_lock_init(&meta->lock);
> +               meta->state = KFENCE_OBJECT_UNUSED;
> +               meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
> +               list_add_tail(&meta->list, &kfence_freelist);
> +
> +               /* Protect the right redzone. */
> +               if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> +                       return false;
> +
> +               addr += 2 * PAGE_SIZE;
> +       }
> +
> +       return true;
> +}
> +
> +/* === DebugFS Interface ==================================================== */
> +
> +static int stats_show(struct seq_file *seq, void *v)
> +{
> +       int i;
> +
> +       seq_printf(seq, "enabled: %i\n", READ_ONCE(kfence_enabled));
> +       for (i = 0; i < KFENCE_COUNTER_COUNT; i++)
> +               seq_printf(seq, "%s: %ld\n", counter_names[i], atomic_long_read(&counters[i]));
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(stats);
> +
> +/*
> + * debugfs seq_file operations for /sys/kernel/debug/kfence/objects.
> + * start_object() and next_object() return the object index + 1, because NULL is used
> + * to stop iteration.
> + */
> +static void *start_object(struct seq_file *seq, loff_t *pos)
> +{
> +       if (*pos < CONFIG_KFENCE_NUM_OBJECTS)
> +               return (void *)((long)*pos + 1);
> +       return NULL;
> +}
> +
> +static void stop_object(struct seq_file *seq, void *v)
> +{
> +}
> +
> +static void *next_object(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +       ++*pos;
> +       if (*pos < CONFIG_KFENCE_NUM_OBJECTS)
> +               return (void *)((long)*pos + 1);
> +       return NULL;
> +}
> +
> +static int show_object(struct seq_file *seq, void *v)
> +{
> +       struct kfence_metadata *meta = &kfence_metadata[(long)v - 1];
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&meta->lock, flags);
> +       kfence_print_object(seq, meta);
> +       raw_spin_unlock_irqrestore(&meta->lock, flags);
> +       seq_puts(seq, "---------------------------------\n");
> +
> +       return 0;
> +}
> +
> +static const struct seq_operations object_seqops = {
> +       .start = start_object,
> +       .next = next_object,
> +       .stop = stop_object,
> +       .show = show_object,
> +};
> +
> +static int open_objects(struct inode *inode, struct file *file)
> +{
> +       return seq_open(file, &object_seqops);
> +}
> +
> +static const struct file_operations objects_fops = {
> +       .open = open_objects,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +};
> +
> +static int __init kfence_debugfs_init(void)
> +{
> +       struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
> +
> +       debugfs_create_file("stats", 0400, kfence_dir, NULL, &stats_fops);
> +       debugfs_create_file("objects", 0400, kfence_dir, NULL, &objects_fops);
> +       return 0;
> +}
> +
> +late_initcall(kfence_debugfs_init);
> +
> +/* === Allocation Gate Timer ================================================ */
> +
> +/*
> + * Set up delayed work, which will enable and disable the static key. We need to
> + * use a work queue (rather than a simple timer), since enabling and disabling a
> + * static key cannot be done from an interrupt.
> + */
> +static struct delayed_work kfence_timer;
> +static void toggle_allocation_gate(struct work_struct *work)
> +{
> +       if (!READ_ONCE(kfence_enabled))
> +               return;
> +
> +       /* Enable static key, and await allocation to happen. */
> +       atomic_set(&allocation_gate, 0);
> +       static_branch_enable(&kfence_allocation_key);
> +       wait_event(allocation_wait, atomic_read(&allocation_gate) != 0);
> +
> +       /* Disable static key and reset timer. */
> +       static_branch_disable(&kfence_allocation_key);
> +       schedule_delayed_work(&kfence_timer, msecs_to_jiffies(kfence_sample_interval));
> +}
> +static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
> +
> +/* === Public interface ===================================================== */
> +
> +void __init kfence_init(void)
> +{
> +       /* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
> +       if (!kfence_sample_interval)
> +               return;
> +
> +       if (!kfence_initialize_pool()) {
> +               pr_err("%s failed\n", __func__);
> +               return;
> +       }
> +
> +       schedule_delayed_work(&kfence_timer, 0);
> +       WRITE_ONCE(kfence_enabled, true);

Can toggle_allocation_gate run before we set kfence_enabled? If yes,
it can break. If not, it's still somewhat confusing.


> +       pr_info("initialized - using %zu bytes for %d objects", KFENCE_POOL_SIZE,
> +               CONFIG_KFENCE_NUM_OBJECTS);
> +       if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> +               pr_cont(" at 0x%px-0x%px\n", (void *)__kfence_pool,
> +                       (void *)(__kfence_pool + KFENCE_POOL_SIZE));
> +       else
> +               pr_cont("\n");
> +}
> +
> +bool kfence_shutdown_cache(struct kmem_cache *s)
> +{
> +       unsigned long flags;
> +       struct kfence_metadata *meta;
> +       int i;
> +
> +       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +               bool in_use;
> +
> +               meta = &kfence_metadata[i];
> +
> +               /*
> +                * If we observe some inconsistent cache and state pair where we
> +                * should have returned false here, cache destruction is racing
> +                * with either kmem_cache_alloc() or kmem_cache_free(). Taking
> +                * the lock will not help, as different critical section
> +                * serialization will have the same outcome.
> +                */
> +               if (READ_ONCE(meta->cache) != s ||
> +                   READ_ONCE(meta->state) != KFENCE_OBJECT_ALLOCATED)
> +                       continue;
> +
> +               raw_spin_lock_irqsave(&meta->lock, flags);
> +               in_use = meta->cache == s && meta->state == KFENCE_OBJECT_ALLOCATED;
> +               raw_spin_unlock_irqrestore(&meta->lock, flags);
> +
> +               if (in_use)
> +                       return false;
> +       }
> +
> +       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +               meta = &kfence_metadata[i];
> +
> +               /* See above. */
> +               if (READ_ONCE(meta->cache) != s || READ_ONCE(meta->state) != KFENCE_OBJECT_FREED)
> +                       continue;
> +
> +               raw_spin_lock_irqsave(&meta->lock, flags);
> +               if (meta->cache == s && meta->state == KFENCE_OBJECT_FREED)
> +                       meta->cache = NULL;
> +               raw_spin_unlock_irqrestore(&meta->lock, flags);
> +       }
> +
> +       return true;
> +}
> +
> +void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> +{
> +       /*
> +        * allocation_gate only needs to become non-zero, so it doesn't make
> +        * sense to continue writing to it and pay the associated contention
> +        * cost, in case we have a large number of concurrent allocations.
> +        */
> +       if (atomic_read(&allocation_gate) || atomic_inc_return(&allocation_gate) > 1)
> +               return NULL;
> +       wake_up(&allocation_wait);
> +
> +       if (!READ_ONCE(kfence_enabled))
> +               return NULL;
> +
> +       if (size > PAGE_SIZE)
> +               return NULL;
> +
> +       return kfence_guarded_alloc(s, size, flags);
> +}
> +
> +size_t kfence_ksize(const void *addr)
> +{
> +       const struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +       /*
> +        * Read locklessly -- if there is a race with __kfence_alloc(), this
> +        * most certainly is either a use-after-free, or invalid access.
> +        */
> +       return meta ? abs(meta->size) : 0;
> +}
> +
> +void *kfence_object_start(const void *addr)
> +{
> +       const struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +       /*
> +        * Read locklessly -- if there is a race with __kfence_alloc(), this
> +        * most certainly is either a use-after-free, or invalid access.
> +        */
> +       return meta ? (void *)meta->addr : NULL;
> +}
> +
> +void __kfence_free(void *addr)
> +{
> +       struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +       if (unlikely(meta->cache->flags & SLAB_TYPESAFE_BY_RCU))

This may deserve a comment as to why we apply rcu on object level
whereas SLAB_TYPESAFE_BY_RCU means slab level only.

> +               call_rcu(&meta->rcu_head, rcu_guarded_free);
> +       else
> +               kfence_guarded_free(addr, meta);
> +}
> +
> +bool kfence_handle_page_fault(unsigned long addr)
> +{
> +       const int page_index = (addr - (unsigned long)__kfence_pool) / PAGE_SIZE;
> +       struct kfence_metadata *to_report = NULL;
> +       enum kfence_error_type error_type;
> +       unsigned long flags;
> +
> +       if (!is_kfence_address((void *)addr))
> +               return false;
> +
> +       if (!READ_ONCE(kfence_enabled)) /* If disabled at runtime ... */
> +               return kfence_unprotect(addr); /* ... unprotect and proceed. */
> +
> +       atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> +
> +       if (page_index % 2) {
> +               /* This is a redzone, report a buffer overflow. */
> +               struct kfence_metadata *meta = NULL;
> +               int distance = 0;
> +
> +               meta = addr_to_metadata(addr - PAGE_SIZE);
> +               if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +                       to_report = meta;
> +                       /* Data race ok; distance calculation approximate. */
> +                       distance = addr - data_race(meta->addr + abs(meta->size));
> +               }
> +
> +               meta = addr_to_metadata(addr + PAGE_SIZE);
> +               if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +                       /* Data race ok; distance calculation approximate. */
> +                       if (!to_report || distance > data_race(meta->addr) - addr)
> +                               to_report = meta;
> +               }
> +
> +               if (!to_report)
> +                       goto out;
> +
> +               raw_spin_lock_irqsave(&to_report->lock, flags);
> +               to_report->unprotected_page = addr;
> +               error_type = KFENCE_ERROR_OOB;
> +
> +               /*
> +                * If the object was freed before we took the look we can still
> +                * report this as an OOB -- the report will simply show the
> +                * stacktrace of the free as well.
> +                */
> +       } else {
> +               to_report = addr_to_metadata(addr);
> +               if (!to_report)
> +                       goto out;
> +
> +               raw_spin_lock_irqsave(&to_report->lock, flags);
> +               error_type = KFENCE_ERROR_UAF;
> +               /*
> +                * We may race with __kfence_alloc(), and it is possible that a
> +                * freed object may be reallocated. We simply report this as a
> +                * use-after-free, with the stack trace showing the place where
> +                * the object was re-allocated.
> +                */
> +       }
> +
> +out:
> +       if (to_report) {
> +               kfence_report_error(addr, to_report, error_type);
> +               raw_spin_unlock_irqrestore(&to_report->lock, flags);
> +       } else {
> +               /* This may be a UAF or OOB access, but we can't be sure. */
> +               kfence_report_error(addr, NULL, KFENCE_ERROR_INVALID);
> +       }
> +
> +       return kfence_unprotect(addr); /* Unprotect and let access proceed. */
> +}
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> new file mode 100644
> index 000000000000..25ce2c0dc092
> --- /dev/null
> +++ b/mm/kfence/kfence.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef MM_KFENCE_KFENCE_H
> +#define MM_KFENCE_KFENCE_H
> +
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "../slab.h" /* for struct kmem_cache */
> +
> +/* For non-debug builds, avoid leaking kernel pointers into dmesg. */
> +#ifdef CONFIG_DEBUG_KERNEL
> +#define PTR_FMT "%px"
> +#else
> +#define PTR_FMT "%p"
> +#endif
> +
> +/*
> + * Get the canary byte pattern for @addr. Use a pattern that varies based on the
> + * lower 3 bits of the address, to detect memory corruptions with higher
> + * probability, where similar constants are used.
> + */
> +#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)addr & 0x7))
> +
> +/* Maximum stack depth for reports. */
> +#define KFENCE_STACK_DEPTH 64
> +
> +/* KFENCE object states. */
> +enum kfence_object_state {
> +       KFENCE_OBJECT_UNUSED, /* Object is unused. */
> +       KFENCE_OBJECT_ALLOCATED, /* Object is currently allocated. */
> +       KFENCE_OBJECT_FREED, /* Object was allocated, and then freed. */
> +};
> +
> +/* KFENCE metadata per guarded allocation. */
> +struct kfence_metadata {
> +       struct list_head list; /* Freelist node; access under kfence_freelist_lock. */
> +       struct rcu_head rcu_head; /* For delayed freeing. */
> +
> +       /*
> +        * Lock protecting below data; to ensure consistency of the below data,
> +        * since the following may execute concurrently: __kfence_alloc(),
> +        * __kfence_free(), kfence_handle_page_fault(). However, note that we
> +        * cannot grab the same metadata off the freelist twice, and multiple
> +        * __kfence_alloc() cannot run concurrently on the same metadata.
> +        */
> +       raw_spinlock_t lock;
> +
> +       /* The current state of the object; see above. */
> +       enum kfence_object_state state;
> +
> +       /*
> +        * Allocated object address; cannot be calculated from size, because of
> +        * alignment requirements.
> +        *
> +        * Invariant: ALIGN_DOWN(addr, PAGE_SIZE) is constant.
> +        */
> +       unsigned long addr;
> +
> +       /*
> +        * The size of the original allocation:
> +        *      size > 0: left page alignment
> +        *      size < 0: right page alignment
> +        */
> +       int size;
> +
> +       /*
> +        * The kmem_cache cache of the last allocation; NULL if never allocated
> +        * or the cache has already been destroyed.
> +        */
> +       struct kmem_cache *cache;
> +
> +       /*
> +        * In case of an invalid access, the page that was unprotected; we
> +        * optimistically only store address.
> +        */
> +       unsigned long unprotected_page;
> +
> +       /* Allocation and free stack information. */
> +       int num_alloc_stack;
> +       int num_free_stack;
> +       unsigned long alloc_stack[KFENCE_STACK_DEPTH];
> +       unsigned long free_stack[KFENCE_STACK_DEPTH];
> +};
> +
> +extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> +
> +/* KFENCE error types for report generation. */
> +enum kfence_error_type {
> +       KFENCE_ERROR_OOB, /* Detected a out-of-bounds access. */
> +       KFENCE_ERROR_UAF, /* Detected a use-after-free access. */
> +       KFENCE_ERROR_CORRUPTION, /* Detected a memory corruption on free. */
> +       KFENCE_ERROR_INVALID, /* Invalid access of unknown type. */
> +       KFENCE_ERROR_INVALID_FREE, /* Invalid free. */
> +};
> +
> +void kfence_report_error(unsigned long address, const struct kfence_metadata *meta,
> +                        enum kfence_error_type type);
> +
> +void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *meta);
> +
> +#endif /* MM_KFENCE_KFENCE_H */
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> new file mode 100644
> index 000000000000..8c28200e7433
> --- /dev/null
> +++ b/mm/kfence/report.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdarg.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/lockdep.h>
> +#include <linux/printk.h>
> +#include <linux/seq_file.h>
> +#include <linux/stacktrace.h>
> +#include <linux/string.h>
> +
> +#include <asm/kfence.h>
> +
> +#include "kfence.h"
> +
> +/* Helper function to either print to a seq_file or to console. */
> +static void seq_con_printf(struct seq_file *seq, const char *fmt, ...)
> +{
> +       va_list args;
> +
> +       va_start(args, fmt);
> +       if (seq)
> +               seq_vprintf(seq, fmt, args);
> +       else
> +               vprintk(fmt, args);
> +       va_end(args);
> +}
> +
> +/* Get the number of stack entries to skip get out of MM internals. */
> +static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries,
> +                           enum kfence_error_type type)
> +{
> +       char buf[64];
> +       int skipnr, fallback = 0;
> +
> +       for (skipnr = 0; skipnr < num_entries; skipnr++) {
> +               int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
> +
> +               /* Depending on error type, find different stack entries. */
> +               switch (type) {
> +               case KFENCE_ERROR_UAF:
> +               case KFENCE_ERROR_OOB:
> +               case KFENCE_ERROR_INVALID:
> +                       if (!strncmp(buf, KFENCE_SKIP_ARCH_FAULT_HANDLER, len))
> +                               goto found;
> +                       break;
> +               case KFENCE_ERROR_CORRUPTION:
> +               case KFENCE_ERROR_INVALID_FREE:
> +                       if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf, "__kfence_"))
> +                               fallback = skipnr + 1; /* In case kfree tail calls into kfence. */
> +
> +                       /* Also the *_bulk() variants by only checking prefixes. */
> +                       if (str_has_prefix(buf, "kfree") || str_has_prefix(buf, "kmem_cache_free"))
> +                               goto found;
> +                       break;
> +               }
> +       }
> +       if (fallback < num_entries)
> +               return fallback;
> +found:
> +       skipnr++;
> +       return skipnr < num_entries ? skipnr : 0;
> +}
> +
> +static void kfence_print_stack(struct seq_file *seq, const struct kfence_metadata *meta,
> +                              bool show_alloc)
> +{
> +       const unsigned long *entries = show_alloc ? meta->alloc_stack : meta->free_stack;
> +       const int nentries = show_alloc ? meta->num_alloc_stack : meta->num_free_stack;
> +
> +       if (nentries) {
> +               int i;
> +
> +               /* stack_trace_seq_print() does not exist; open code our own. */
> +               for (i = 0; i < nentries; i++)
> +                       seq_con_printf(seq, " %pS\n", entries[i]);
> +       } else {
> +               seq_con_printf(seq, " no %s stack\n", show_alloc ? "allocation" : "deallocation");
> +       }
> +}
> +
> +void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *meta)
> +{
> +       const int size = abs(meta->size);

This negative encoding is somewhat confusing. We do lots of abs, but
do we even look at the sign anywhere? I can't find any use that is not
abs.

> +       const unsigned long start = meta->addr;
> +       const struct kmem_cache *const cache = meta->cache;
> +
> +       lockdep_assert_held(&meta->lock);
> +
> +       if (meta->state == KFENCE_OBJECT_UNUSED) {
> +               seq_con_printf(seq, "kfence-#%zd unused\n", meta - kfence_metadata);
> +               return;
> +       }
> +
> +       seq_con_printf(seq,
> +                      "kfence-#%zd [0x" PTR_FMT "-0x" PTR_FMT
> +                      ", size=%d, cache=%s] allocated in:\n",
> +                      meta - kfence_metadata, (void *)start, (void *)(start + size - 1), size,
> +                      (cache && cache->name) ? cache->name : "<destroyed>");
> +       kfence_print_stack(seq, meta, true);
> +
> +       if (meta->state == KFENCE_OBJECT_FREED) {
> +               seq_con_printf(seq, "freed in:\n");
> +               kfence_print_stack(seq, meta, false);
> +       }
> +}
> +
> +/*
> + * Show bytes at @addr that are different from the expected canary values, up to
> + * @max_bytes.
> + */
> +static void print_diff_canary(const u8 *addr, size_t max_bytes)
> +{
> +       const u8 *max_addr = min((const u8 *)PAGE_ALIGN((unsigned long)addr), addr + max_bytes);
> +
> +       pr_cont("[");
> +       for (; addr < max_addr; addr++) {
> +               if (*addr == KFENCE_CANARY_PATTERN(addr))
> +                       pr_cont(" .");
> +               else if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> +                       pr_cont(" 0x%02x", *addr);
> +               else /* Do not leak kernel memory in non-debug builds. */
> +                       pr_cont(" !");
> +       }
> +       pr_cont(" ]");
> +}
> +
> +void kfence_report_error(unsigned long address, const struct kfence_metadata *meta,
> +                        enum kfence_error_type type)
> +{
> +       unsigned long stack_entries[KFENCE_STACK_DEPTH] = { 0 };
> +       int num_stack_entries = stack_trace_save(stack_entries, KFENCE_STACK_DEPTH, 1);
> +       int skipnr = get_stack_skipnr(stack_entries, num_stack_entries, type);
> +
> +       /* KFENCE_ERROR_OOB requires non-NULL meta; for the rest it's optional. */
> +       if (WARN_ON(type == KFENCE_ERROR_OOB && !meta))
> +               return;
> +
> +       if (meta)
> +               lockdep_assert_held(&meta->lock);
> +       /*
> +        * Because we may generate reports in printk-unfriendly parts of the
> +        * kernel, such as scheduler code, the use of printk() could deadlock.
> +        * Until such time that all printing code here is safe in all parts of
> +        * the kernel, accept the risk, and just get our message out (given the
> +        * system might already behave unpredictably due to the memory error).
> +        * As such, also disable lockdep to hide warnings, and avoid disabling
> +        * lockdep for the rest of the kernel.
> +        */
> +       lockdep_off();
> +
> +       pr_err("==================================================================\n");
> +       /* Print report header. */
> +       switch (type) {
> +       case KFENCE_ERROR_OOB:
> +               pr_err("BUG: KFENCE: out-of-bounds in %pS\n\n", (void *)stack_entries[skipnr]);
> +               pr_err("Out-of-bounds access at 0x" PTR_FMT " (%s of kfence-#%zd):\n",
> +                      (void *)address, address < meta->addr ? "left" : "right",
> +                      meta - kfence_metadata);
> +               break;
> +       case KFENCE_ERROR_UAF:
> +               pr_err("BUG: KFENCE: use-after-free in %pS\n\n", (void *)stack_entries[skipnr]);
> +               pr_err("Use-after-free access at 0x" PTR_FMT ":\n", (void *)address);
> +               break;
> +       case KFENCE_ERROR_CORRUPTION:
> +               pr_err("BUG: KFENCE: memory corruption in %pS\n\n", (void *)stack_entries[skipnr]);
> +               pr_err("Detected corrupted memory at 0x" PTR_FMT " ", (void *)address);
> +               print_diff_canary((u8 *)address, 16);
> +               pr_cont(":\n");
> +               break;
> +       case KFENCE_ERROR_INVALID:
> +               pr_err("BUG: KFENCE: invalid access in %pS\n\n", (void *)stack_entries[skipnr]);
> +               pr_err("Invalid access at 0x" PTR_FMT ":\n", (void *)address);
> +               break;
> +       case KFENCE_ERROR_INVALID_FREE:
> +               pr_err("BUG: KFENCE: invalid free in %pS\n\n", (void *)stack_entries[skipnr]);
> +               pr_err("Invalid free of 0x" PTR_FMT ":\n", (void *)address);
> +               break;
> +       }
> +
> +       /* Print stack trace and object info. */
> +       stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr, 0);
> +
> +       if (meta) {
> +               pr_err("\n");
> +               kfence_print_object(NULL, meta);
> +       }
> +
> +       /* Print report footer. */
> +       pr_err("\n");
> +       dump_stack_print_info(KERN_DEFAULT);
> +       pr_err("==================================================================\n");
> +
> +       lockdep_on();
> +
> +       if (panic_on_warn)
> +               panic("panic_on_warn set ...\n");
> +
> +       /* We encountered a memory unsafety error, taint the kernel! */
> +       add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> +}
> --
> 2.28.0.526.ge36021eeef-goog
>
