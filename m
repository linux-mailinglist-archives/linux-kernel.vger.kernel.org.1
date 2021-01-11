Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178CA2F2494
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbhALAY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403926AbhAKXN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:13:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1972C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:13:15 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s26so484768lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Fqf+/a7LJ2TNHBRavbbePV+3oAWOSA8RuMRd1jeZWrA=;
        b=ObSIRMYCNS87XVwdA0cVR/xqUTcpbbJaUZ0qnwyk6g20c58h8VLfZpWFuNER0L55dx
         S5mo4KgV2FyIRmpx9BGPS9ToFKMblFA2B4QFndDJAnspWGBaNaeteiOrUTUYvGMpjRIn
         qD6z+aPOrHNicuJs2M4usfecaelzDc6NviQcYdBX8LmaG/fcYYru0Ush7AysXHabKPdI
         AfxdbNu1JDa9gScf2CMMmmb3dgGzZYxdk0XdTC7CJyh/m8a3Ov/9WW3xiFqWy3mFBW12
         6Eu0Nf4cZbt7dPgHBFYcHE6WBwGHMXYguT8y88dn5eW2eifEBP4ylL0KTvaySQdp0tMh
         n4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fqf+/a7LJ2TNHBRavbbePV+3oAWOSA8RuMRd1jeZWrA=;
        b=aEgcPKp4nXxEVadLIAq0BMdBoGFR1bflCakBI0pxHx6I1/Q8GApxzrTM/4Ua0t6AD0
         vfqJ6RC45amQmhyyIyRgRflivG8giRYNFAueJUZOTLxD5x5XdTdEZ0NpoMrQPBzG6rnw
         f1H6pZDm40/O6osoUFmF9smY7w3w/uhUdbwvJCl9tqubuVUWzNl6OzqVZDPMcUBBjJnJ
         cQhhmDx1ajOMybSrzDBP99ZHydU0REYxwbyI6+OOkEhmkaoHlsr7Zz2y8taHeT70ivgt
         WWLxoc4HDZ8GOs24Ea6Ws8QFnDQTyFSwZ19x5ITyMM/zWmgIjXZnUtBZmRU0dGQ9UbPk
         nnHA==
X-Gm-Message-State: AOAM532todFjyRRZkAKShVa6gTw3qygQMVkH+/YfBOGpDtEG9IGKbFnq
        AHqJsVfkzyLLfnjsOPn7dz72OO0FebDEm8N+7CtOoUaJ6apGwA==
X-Google-Smtp-Source: ABdhPJyBScnzRL3Ahzoe0r3NdUZdeIx6ECgy6009Rgg6fTW6VwMByOK7IeNgsLmBVjmoOOvN+7cva3Rh/vhV3ZQq0Do=
X-Received: by 2002:a19:8210:: with SMTP id e16mr713502lfd.69.1610406793804;
 Mon, 11 Jan 2021 15:13:13 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 12 Jan 2021 00:12:47 +0100
Message-ID: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
Subject: SLUB: percpu partial object count is highly inaccurate, causing some
 memory wastage and maybe also worse tail latencies?
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This is not something I intend to work on myself. But since I
stumbled over this issue, I figured I should at least document/report
it, in case anyone is willing to pick it up.]

Hi!

I was poking around in SLUB internals and noticed that the estimate of
how many free objects exist on a percpu partial list (tracked in
page->pobjects of the first page on the list and exposed to userspace
via /sys/kernel/slab/*/slabs_cpu_partial) is highly inaccurate.

From a naive first look, it seems like SLUB tries to roughly keep up
to cache->cpu_partial free objects per slab and CPU around.
cache->cpu_partial depends on the object size; the maximum is 30 (for
objects <256 bytes).

However, the accounting of free objects into page->pobjects only
happens when a page is added to the percpu partial list;
page->pobjects is not updated when objects are freed to a page that is
already on the percpu partial list. Pages can be added to the percpu
partial list in two cases:

1. When an object is freed from a page which previously had zero free
objects (via __slab_free()), meaning the page was not previously on
any list.
2. When the percpu partial list was empty and get_partial_node(),
after grabbing a partial page from the node, moves more partial pages
onto the percpu partial list to make the percpu partial list contain
around cache->cpu_partial/2 free objects.

In case 1, pages will almost always be counted as having one free
object, unless a race with a concurrent __slab_free() on the same page
happens, because the code path specifically handles the case where the
number of free objects just became 1.
In case 2, pages will probably often be counted as having many free
objects; however, this case doesn't appear to happen often in
practice, likely partly because pages outside of percpu partial lists
get freed immediately when they become empty.


This means that in practice, SLUB actually ends up keeping as many
**pages** on the percpu partial lists as it intends to keep **free
objects** there. To see this, you can append the snippet at the end of
this mail to mm/slub.c; that will add a debugfs entry that lets you
accurately dump the percpu partial lists of all running CPUs (at the
cost of an IPI storm when you read it).

Especially after running some forkbombs multiple times on a VM with a
bunch of CPUs, that will show you that some of the percpu lists look
like this (just showing a single slab's percpu lists on three CPU
cores here) - note the "inuse=0" everywhere:

task_delay_info on 10:
  page=fffff9e4444b9b00 base=ffff988bd2e6c000 order=0 partial_pages=24
partial_objects=24 objects=51 inuse=0
  page=fffff9e44469f800 base=ffff988bda7e0000 order=0 partial_pages=23
partial_objects=23 objects=51 inuse=0
  page=fffff9e444e01380 base=ffff988bf804e000 order=0 partial_pages=22
partial_objects=22 objects=51 inuse=0
  page=fffff9e444bdda40 base=ffff988bef769000 order=0 partial_pages=21
partial_objects=21 objects=51 inuse=0
  page=fffff9e444c59700 base=ffff988bf165c000 order=0 partial_pages=20
partial_objects=20 objects=51 inuse=0
  page=fffff9e44494d280 base=ffff988be534a000 order=0 partial_pages=19
partial_objects=19 objects=51 inuse=0
  page=fffff9e444fd2e80 base=ffff988bff4ba000 order=0 partial_pages=18
partial_objects=18 objects=51 inuse=0
  page=fffff9e444c47c80 base=ffff988bf11f2000 order=0 partial_pages=17
partial_objects=17 objects=51 inuse=0
  page=fffff9e4448ff780 base=ffff988be3fde000 order=0 partial_pages=16
partial_objects=16 objects=51 inuse=0
  page=fffff9e4443883c0 base=ffff988bce20f000 order=0 partial_pages=15
partial_objects=15 objects=51 inuse=0
  page=fffff9e444eede40 base=ffff988bfbb79000 order=0 partial_pages=14
partial_objects=14 objects=51 inuse=0
  page=fffff9e4442febc0 base=ffff988bcbfaf000 order=0 partial_pages=13
partial_objects=13 objects=51 inuse=0
  page=fffff9e444e44940 base=ffff988bf9125000 order=0 partial_pages=12
partial_objects=12 objects=51 inuse=0
  page=fffff9e4446f72c0 base=ffff988bdbdcb000 order=0 partial_pages=11
partial_objects=11 objects=51 inuse=0
  page=fffff9e444dba080 base=ffff988bf6e82000 order=0 partial_pages=10
partial_objects=10 objects=51 inuse=0
  page=fffff9e444a23c40 base=ffff988be88f1000 order=0 partial_pages=9
partial_objects=9 objects=51 inuse=0
  page=fffff9e444786cc0 base=ffff988bde1b3000 order=0 partial_pages=8
partial_objects=8 objects=51 inuse=0
  page=fffff9e444b2cf80 base=ffff988becb3e000 order=0 partial_pages=7
partial_objects=7 objects=51 inuse=0
  page=fffff9e444f19cc0 base=ffff988bfc673000 order=0 partial_pages=6
partial_objects=6 objects=51 inuse=0
  page=fffff9e444f08fc0 base=ffff988bfc23f000 order=0 partial_pages=5
partial_objects=5 objects=51 inuse=0
  page=fffff9e444a0e540 base=ffff988be8395000 order=0 partial_pages=4
partial_objects=4 objects=51 inuse=0
  page=fffff9e445127a00 base=ffff988c049e8000 order=0 partial_pages=3
partial_objects=3 objects=51 inuse=0
  page=fffff9e44468ae40 base=ffff988bda2b9000 order=0 partial_pages=2
partial_objects=2 objects=51 inuse=0
  page=fffff9e44452c9c0 base=ffff988bd4b27000 order=0 partial_pages=1
partial_objects=1 objects=51 inuse=0
task_delay_info on 11:
  page=fffff9e444a90c40 base=ffff988bea431000 order=0 partial_pages=22
partial_objects=22 objects=51 inuse=0
  page=fffff9e444447040 base=ffff988bd11c1000 order=0 partial_pages=21
partial_objects=21 objects=51 inuse=0
  page=fffff9e446505b40 base=ffff988c5416d000 order=0 partial_pages=20
partial_objects=20 objects=51 inuse=0
  page=fffff9e444c02500 base=ffff988bf0094000 order=0 partial_pages=19
partial_objects=19 objects=51 inuse=0
  page=fffff9e4447ceec0 base=ffff988bdf3bb000 order=0 partial_pages=18
partial_objects=18 objects=51 inuse=0
  page=fffff9e444524a40 base=ffff988bd4929000 order=0 partial_pages=17
partial_objects=17 objects=51 inuse=0
  page=fffff9e444698700 base=ffff988bda61c000 order=0 partial_pages=16
partial_objects=16 objects=51 inuse=0
  page=fffff9e444d23240 base=ffff988bf48c9000 order=0 partial_pages=15
partial_objects=15 objects=51 inuse=0
  page=fffff9e4442ccac0 base=ffff988bcb32b000 order=0 partial_pages=14
partial_objects=14 objects=51 inuse=0
  page=fffff9e444a03500 base=ffff988be80d4000 order=0 partial_pages=13
partial_objects=13 objects=51 inuse=0
  page=fffff9e444582ec0 base=ffff988bd60bb000 order=0 partial_pages=12
partial_objects=12 objects=51 inuse=0
  page=fffff9e444e5a340 base=ffff988bf968d000 order=0 partial_pages=11
partial_objects=11 objects=51 inuse=0
  page=fffff9e4444bb680 base=ffff988bd2eda000 order=0 partial_pages=10
partial_objects=10 objects=51 inuse=0
  page=fffff9e444232100 base=ffff988bc8c84000 order=0 partial_pages=9
partial_objects=9 objects=51 inuse=0
  page=fffff9e444acb2c0 base=ffff988beb2cb000 order=0 partial_pages=8
partial_objects=8 objects=51 inuse=0
  page=fffff9e44512cdc0 base=ffff988c04b37000 order=0 partial_pages=7
partial_objects=7 objects=51 inuse=0
  page=fffff9e44474f040 base=ffff988bdd3c1000 order=0 partial_pages=6
partial_objects=6 objects=51 inuse=0
  page=fffff9e4446dee80 base=ffff988bdb7ba000 order=0 partial_pages=5
partial_objects=5 objects=51 inuse=0
  page=fffff9e444c19fc0 base=ffff988bf067f000 order=0 partial_pages=4
partial_objects=4 objects=51 inuse=0
  page=fffff9e444a07a80 base=ffff988be81ea000 order=0 partial_pages=3
partial_objects=3 objects=51 inuse=0
  page=fffff9e444e6ac80 base=ffff988bf9ab2000 order=0 partial_pages=2
partial_objects=2 objects=51 inuse=0
  page=fffff9e4442e5ec0 base=ffff988bcb97b000 order=0 partial_pages=1
partial_objects=1 objects=51 inuse=0
task_delay_info on 12:
  page=fffff9e4446d0880 base=ffff988bdb422000 order=0 partial_pages=27
partial_objects=27 objects=51 inuse=0
  page=fffff9e44485f5c0 base=ffff988be17d7000 order=0 partial_pages=26
partial_objects=26 objects=51 inuse=0
  page=fffff9e444ff8180 base=ffff988bffe06000 order=0 partial_pages=25
partial_objects=25 objects=51 inuse=0
  page=fffff9e444727d00 base=ffff988bdc9f4000 order=0 partial_pages=24
partial_objects=24 objects=51 inuse=0
  page=fffff9e444dc7a80 base=ffff988bf71ea000 order=0 partial_pages=23
partial_objects=23 objects=51 inuse=0
  page=fffff9e4443c7600 base=ffff988bcf1d8000 order=0 partial_pages=22
partial_objects=22 objects=51 inuse=0
  page=fffff9e444d76580 base=ffff988bf5d96000 order=0 partial_pages=21
partial_objects=21 objects=51 inuse=0
  page=fffff9e4446d20c0 base=ffff988bdb483000 order=0 partial_pages=20
partial_objects=20 objects=51 inuse=0
  page=fffff9e4448b9c00 base=ffff988be2e70000 order=0 partial_pages=19
partial_objects=19 objects=51 inuse=0
  page=fffff9e444781900 base=ffff988bde064000 order=0 partial_pages=18
partial_objects=18 objects=51 inuse=0
  page=fffff9e4465dd4c0 base=ffff988c57753000 order=0 partial_pages=17
partial_objects=17 objects=51 inuse=0
  page=fffff9e4446f2340 base=ffff988bdbc8d000 order=0 partial_pages=16
partial_objects=16 objects=51 inuse=0
  page=fffff9e4449c4f40 base=ffff988be713d000 order=0 partial_pages=15
partial_objects=15 objects=51 inuse=0
  page=fffff9e445106b80 base=ffff988c041ae000 order=0 partial_pages=14
partial_objects=14 objects=51 inuse=0
  page=fffff9e444b7b9c0 base=ffff988bedee7000 order=0 partial_pages=13
partial_objects=13 objects=51 inuse=0
  page=fffff9e44422c400 base=ffff988bc8b10000 order=0 partial_pages=12
partial_objects=12 objects=51 inuse=0
  page=fffff9e444eb2240 base=ffff988bfac89000 order=0 partial_pages=11
partial_objects=11 objects=51 inuse=0
  page=fffff9e44455ce40 base=ffff988bd5739000 order=0 partial_pages=10
partial_objects=10 objects=51 inuse=0
  page=fffff9e44490f440 base=ffff988be43d1000 order=0 partial_pages=9
partial_objects=9 objects=51 inuse=0
  page=fffff9e444b640c0 base=ffff988bed903000 order=0 partial_pages=8
partial_objects=8 objects=51 inuse=0
  page=fffff9e444877c40 base=ffff988be1df1000 order=0 partial_pages=7
partial_objects=7 objects=51 inuse=0
  page=fffff9e444ef72c0 base=ffff988bfbdcb000 order=0 partial_pages=6
partial_objects=6 objects=51 inuse=0
  page=fffff9e444a6d040 base=ffff988be9b41000 order=0 partial_pages=5
partial_objects=5 objects=51 inuse=0
  page=fffff9e444503340 base=ffff988bd40cd000 order=0 partial_pages=4
partial_objects=4 objects=51 inuse=0
  page=fffff9e444e408c0 base=ffff988bf9023000 order=0 partial_pages=3
partial_objects=3 objects=51 inuse=0
  page=fffff9e445a55a80 base=ffff988c2956a000 order=0 partial_pages=2
partial_objects=2 objects=51 inuse=0
  page=fffff9e444486480 base=ffff988bd2192000 order=0 partial_pages=1
partial_objects=1 objects=51 inuse=0

Even on an old-ish Android phone (Pixel 2), with normal-ish usage, I
see something like 1.5MiB of pages with zero inuse objects stuck in
percpu lists.

I suspect that this may have also contributed to the memory wastage
problem with memory cgroups that was fixed in v5.9
(https://lore.kernel.org/linux-mm/20200623174037.3951353-1-guro@fb.com/);
meaning that servers with lots of CPU cores running pre-5.9 kernels
with memcg and systemd (which tends to stick every service into its
own memcg) might be even worse off.

It also seems unsurprising to me that flushing ~30 pages out of the
percpu partial caches at once with IRQs disabled would cause tail
latency spikes (as noted by Joonsoo Kim and Christoph Lameter in
commit 345c905d13a4e "slub: Make cpu partial slab support
configurable").

At first I thought that this wasn't a significant issue because SLUB
has a reclaim path that can trim the percpu partial lists; but as it
turns out, that reclaim path is not actually wired up to the page
allocator's reclaim logic. The SLUB reclaim stuff is only triggered by
(very rare) subsystem-specific calls into SLUB for specific slabs and
by sysfs entries. So in userland processes will OOM even if SLUB still
has megabytes of entirely unused pages lying around.

It might be a good idea to figure out whether it is possible to
efficiently keep track of a more accurate count of the free objects on
percpu partial lists; and if not, maybe change the accounting to
explicitly track the number of partial pages, and use limits that are
more appropriate for that? And perhaps the page allocator reclaim path
should also occasionally rip unused pages out of the percpu partial
lists?

If you want to manually try reaping memory from the percpu partial
lists one time, you may want to try writing 1 into all
/sys/kernel/slab/*/shrink and see what effect that has on memory
usage, especially on the "Slab" line in /proc/meminfo. On my laptop
(running some kernel older than 5.9) that caused Slab memory usage to
drop from 652096 kB to 580780 kB, a relative 11% reduction in page
usage by the slab allocator, and an absolute ~70 MiB reduction. On my
(mostly idle) 56-core workstation (running the same kernel), it
reduced slab memory usage by ~13% / ~1.35 GiB:

# for i in {0..5}; do grep Slab /proc/meminfo; sleep 5; done; for file
in /sys/kernel/slab/*/shrink; do echo 1 > $file; done; for i in
{0..5}; do grep Slab /proc/meminfo; sleep 5; done
Slab:           10902060 kB
Slab:           10902528 kB
Slab:           10902528 kB
Slab:           10902728 kB
Slab:           10902696 kB
Slab:           10902712 kB
Slab:            9485364 kB
Slab:            9424864 kB
Slab:            9429188 kB
Slab:            9430656 kB
Slab:            9431020 kB
Slab:            9431764 kB


=============================
#ifdef CONFIG_SLUB_CPU_PARTIAL
struct partial_dump_state {
        int cache_idx;
        struct kmem_cache *cache;
        int cpu;
};

static void *partial_dump_start(struct seq_file *m, loff_t *pos)
{
        struct partial_dump_state *ds = m->private;

        mutex_lock(&slab_mutex);
        ds->cache = list_first_entry(&slab_caches, struct kmem_cache, list);
        if (*pos == 0) {
                ds->cache_idx = 0;
                ds->cpu = cpumask_next(-1, cpu_possible_mask);
        } else  {
                int i;

                for (i = 0; i < ds->cache_idx; i++) {
                        if (list_is_last(&ds->cache->list, &slab_caches))
                                return NULL;
                        ds->cache = list_next_entry(ds->cache, list);
                }

        }
        return (void*)1UL;
}

static void *partial_dump_next(struct seq_file *m, void *v, loff_t *pos)
{
        struct partial_dump_state *ds = m->private;

        (*pos)++; /* meaningless but seq_file complains if we don't */
        ds->cpu = cpumask_next(ds->cpu, cpu_possible_mask);
        if (ds->cpu >= num_possible_cpus()) {
                ds->cpu = cpumask_next(-1, cpu_possible_mask);

                ds->cache_idx++;
                if (list_is_last(&ds->cache->list, &slab_caches))
                        return NULL;
                ds->cache = list_next_entry(ds->cache, list);
        }
        return (void*)1UL;
}

static void empty_stop(struct seq_file *m, void *p) {
        struct partial_dump_state *ds = m->private;

        ds->cache = NULL;
        mutex_unlock(&slab_mutex);
}

static void partial_dump_on_cpu(void *info)
{
        struct seq_file *m = info;
        struct partial_dump_state *ds = m->private;
        struct kmem_cache_cpu *c = per_cpu_ptr(ds->cache->cpu_slab, ds->cpu);
        struct page *page;

        if (WARN_ON(smp_processor_id() != ds->cpu))
                return;

        seq_printf(m, "%s on %d:\n", ds->cache->name, ds->cpu);
        page = c->partial;
        for (page = c->partial; page != NULL; page = page->next) {
                seq_printf(m, "  page=%px base=%px order=%d
partial_pages=%d partial_objects=%d objects=%u inuse=%u\n",
                           page,
                           page_address(page),
                           compound_order(page),
                           page->pages,
                           page->pobjects,
                           page->objects,
                           page->inuse);
        }
}

static int partial_dump_show(struct seq_file *m, void *p)
{
        struct partial_dump_state *ds = m->private;

        if (smp_call_function_single(ds->cpu, partial_dump_on_cpu, m, 1))
                seq_printf(m, "%s on %d: not online\n",
ds->cache->name, ds->cpu);

        return 0;
}

static const struct seq_operations partial_dump_seq_ops = {
        .start = partial_dump_start,
        .next = partial_dump_next,
        .stop = empty_stop,
        .show = partial_dump_show
};

static int partial_dump_open(struct inode *inode, struct file *file)
{
        return seq_open_private(file, &partial_dump_seq_ops,
sizeof(struct partial_dump_state));
}

static const struct file_operations partial_dump_ops = {
        .open = partial_dump_open,
        .read = seq_read,
        .llseek = seq_lseek,
        .release = seq_release
};
#endif

#include <linux/debugfs.h>
static int __init slub_debugfs_init(void)
{
        struct dentry *dir = debugfs_create_dir("slub", NULL);

#ifdef CONFIG_SLUB_CPU_PARTIAL
        debugfs_create_file("partial_dump", 0400, dir, NULL, &partial_dump_ops);
#endif

        return 0;
}
late_initcall(slub_debugfs_init);
=============================
