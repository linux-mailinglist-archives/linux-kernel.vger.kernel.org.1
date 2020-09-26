Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8B279763
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 08:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgIZG5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 02:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZG5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 02:57:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9066C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:57:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id n133so5351014qkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElMbl9FGWVUm1Yrk69NIS8KWp3PMh9I8eCVmETr6sBI=;
        b=B6YOE4J2uBMzvuuykFy3iR25C29BGMwkBYHLPjDBEZWUr2B4dBfJJphERMbOvyaoF7
         9k05UfqDgJsCIlsmY+yF4LSlePpoJd5eZ4vRhV7xFpEFWnxNwouS+NGz42YrH2vzS41+
         ukdn6Mnmu4wpeJTSNHKvGfKA/CoN9jbWg9SZaiT60HQXCU/Nn1RbreEtnBJayrQWSEXx
         CYydPcUHR8JUrZZEjUQ2mOGTmRhAb4NNe2HAPwOBPH7zUcTXJs3cC9nEKvLUxBkav6J0
         AshkHxQtJBN0j9k0jnplKxIeuR9fTD8wJ8u/eF4lj6nQt3yX4Tgv3SmDkxRz6HBT+aRw
         OiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElMbl9FGWVUm1Yrk69NIS8KWp3PMh9I8eCVmETr6sBI=;
        b=nVith0vcvWB+GWEye5VAOJqO62eyfhd+t74JCknAPokvvHL0w3x9sKqDSnnXCnPf5X
         /u9Ng72RSYjk57oxXbMMaogL0KEPYFIahedVQquIblb8bnxtt4rEl63u8aoxbk30KQDF
         vkI6IzGhYziTCIJGTAcCWFDxDDPDzb5F/XVMUIjEgBva+FaAhzDjsc3et0K3+iNHurVa
         Ho3RPy1dUthOETW4JOAgDfAglDL0bpLqJEkBFq6I7lFA0nM1YCkN4OXmt8czIZDT6S7s
         wiTh6cpq9Jep8J69nbCFGu8SlkwbMZP8zK7t2uLhhOYiNZxmfd6kksB9t+mbGR+rd4F1
         ofsQ==
X-Gm-Message-State: AOAM533Ej86feGmiLQhXWZN3N/B5CrZ78/gnENxZlmq7EW52VQCRbiZp
        apyFtXiRgzM1kk1qdL9r7IMyg5K+Y+XknxkiEB/dZA==
X-Google-Smtp-Source: ABdhPJyN/frkjhtF4Jks1nBXn2FBVLfZmpCQNUtFiVeY2btEUADusm6JXAMsMlzNL62Z5pP57pLNTRa2e/CQcEAZkk8=
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr3495736qke.250.1601103463438;
 Fri, 25 Sep 2020 23:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200925184327.7257b6bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200925184327.7257b6bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 26 Sep 2020 08:57:32 +0200
Message-ID: <CACT4Y+bK+0aeJb_2ULmouuH3+_OPOqMTtv1UOp2td73cqcZL-w@mail.gmail.com>
Subject: Re: KASAN vs RCU vs RT
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 3:43 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hi!
>
> I couldn't find this being reported in a quick search, so let me ask.
>
> With 5.9 I'm seeing a lot (well, once a boot) splats like the one below.
>
> Is there a fix?

Hi Jakub,

FWIW this is the first time I see this BUG. I don't remember it was
mentioned on kasan-dev before.

The commit that added this BUG was added in March 2020, so is not new...

> [  563.227358] =============================
> [  563.227722] [ BUG: Invalid wait context ]
> [  563.228063] 5.9.0-rc6-02036-g7e4a153c60d2-dirty #267 Not tainted
> [  563.228606] -----------------------------
> [  563.228950] NetworkManager/758 is trying to lock:
> [  563.229344] ffffffffa74b5ad8 (depot_lock){-.-.}-{3:3}, at: stack_depot_save+0x1c5/0x3f0
> [  563.229996] other info that might help us debug this:
> [  563.230406] context-{5:5}
> [  563.230641] 7 locks held by NetworkManager/758:
> [  563.231006]  #0: ffff88804d6f00f0 (&f->f_pos_lock){+.+.}-{4:4}, at: __fdget_pos+0x71/0x80
> [  563.231658]  #1: ffff88805692c450 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x2a7/0x350
> [  563.232290]  #2: ffffffffa7763b28 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_sysctl_disable+0x186/0x350
> [  563.232998]  #3: ffff888033e911a0 (&ndev->lock){++.-}-{3:3}, at: ipv6_mc_down+0x1d/0x150
> [  563.233674]  #4: ffff88804f0f24c0 (&mc->mca_lock){+.-.}-{3:3}, at: igmp6_group_dropped+0xfa/0x550
> [  563.234437]  #5: ffff888045688280 (_xmit_ETHER){+...}-{3:3}, at: dev_mc_del+0x1f/0x70
> [  563.235119]  #6: ffff88805ae23890 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x6c/0x380
> [  563.235846] stack backtrace:
> [  563.236146] CPU: 0 PID: 758 Comm: NetworkManager Not tainted 5.9.0-rc6-02036-g7e4a153c60d2-dirty #267
> [  563.236949] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> [  563.237685] Call Trace:
> [  563.237948]  dump_stack+0xae/0xe8
> [  563.238279]  __lock_acquire.cold+0x1b9/0x34d
> [  563.238689]  ? lock_downgrade+0x3a0/0x3a0
> [  563.239070]  ? stack_access_ok+0x3a/0x90
> [  563.239510]  ? lockdep_hardirqs_on_prepare+0x260/0x260
> [  563.239997]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  563.240474]  lock_acquire+0x14f/0x5e0
> [  563.240882]  ? stack_depot_save+0x1c5/0x3f0
> [  563.241297]  ? lock_release+0x430/0x430
> [  563.241693]  ? arch_stack_walk+0xa2/0xf0
> [  563.242069]  _raw_spin_lock_irqsave+0x48/0x60
> [  563.242484]  ? stack_depot_save+0x1c5/0x3f0
> [  563.242868]  stack_depot_save+0x1c5/0x3f0
> [  563.243242]  kasan_save_stack+0x32/0x40
> [  563.243609]  ? kasan_save_stack+0x1b/0x40
> [  563.243983]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
> [  563.244431]  ? kmem_cache_alloc+0xee/0x2e0
> [  563.244810]  ? fill_pool+0x211/0x320
> [  563.245149]  ? __debug_object_init+0x7d/0x610
> [  563.245551]  ? debug_object_activate+0x2bb/0x2e0
> [  563.245968]  ? kvfree_call_rcu+0x7b/0x380
> [  563.246342]  ? __hw_addr_del_entry+0x110/0x140
> [  563.246766]  ? dev_mc_del+0x4c/0x70
> [  563.247122]  ? igmp6_group_dropped+0x1ab/0x550
> [  563.247551]  ? ipv6_mc_down+0x37/0x150
> [  563.247921]  ? addrconf_ifdown.isra.0+0x924/0xaa0
> [  563.248365]  ? dev_disable_change+0xb6/0x130
> [  563.248781]  ? addrconf_sysctl_disable+0x227/0x350
> [  563.249232]  ? proc_sys_call_handler.isra.0+0x172/0x310
> [  563.250571]  ? vfs_write+0x159/0x350
> [  563.250922]  ? ksys_write+0xc9/0x160
> [  563.251283]  ? do_syscall_64+0x33/0x40
> [  563.251648]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  563.252118]  ? mark_lock+0x90/0xb20
> [  563.252472]  ? __lock_acquire+0x85c/0x2f50
> [  563.252861]  ? mark_lock+0x90/0xb20
> [  563.253207]  ? lockdep_hardirqs_on_prepare+0x260/0x260
> [  563.253677]  ? __lock_acquire+0x85c/0x2f50
> [  563.254067]  ? mark_lock+0x90/0xb20
> [  563.254418]  ? kasan_unpoison_shadow+0x33/0x40
> [  563.254833]  __kasan_kmalloc.constprop.0+0xc2/0xd0
> [  563.255278]  kmem_cache_alloc+0xee/0x2e0
> [  563.255659]  fill_pool+0x211/0x320
> [  563.255999]  ? __list_del_entry_valid.cold+0x4f/0x4f
> [  563.256458]  ? lockdep_hardirqs_on_prepare+0x260/0x260
> [  563.256945]  ? __lock_acquire+0x85c/0x2f50
> [  563.257333]  __debug_object_init+0x7d/0x610
> [  563.257742]  ? debug_object_destroy+0x150/0x150
> [  563.258163]  debug_object_activate+0x2bb/0x2e0
> [  563.258580]  ? debug_object_assert_init+0x230/0x230
> [  563.259058]  ? rwlock_bug.part.0+0x60/0x60
> [  563.259478]  kvfree_call_rcu+0x7b/0x380
> [  563.259848]  __hw_addr_del_entry+0x110/0x140
> [  563.260256]  dev_mc_del+0x4c/0x70
> [  563.260596]  igmp6_group_dropped+0x1ab/0x550
> [  563.260998]  ? igmp6_send+0xa30/0xa30
> [  563.261360]  ? mark_held_locks+0x65/0x90
> [  563.261736]  ipv6_mc_down+0x37/0x150
> [  563.262088]  addrconf_ifdown.isra.0+0x924/0xaa0
> [  563.262514]  ? lock_acquire+0x14f/0x5e0
> [  563.262883]  ? add_addr+0x1c0/0x1c0
> [  563.263227]  ? lock_release+0x430/0x430
> [  563.263603]  ? create_object.isra.0+0x212/0x530
> [  563.264022]  ? lock_is_held_type+0xbb/0xf0
> [  563.264415]  dev_disable_change+0xb6/0x130
> [  563.264809]  ? addrconf_notify+0x1220/0x1220
> [  563.265214]  ? mutex_trylock+0x169/0x180
> [  563.265593]  ? addrconf_sysctl_disable+0x186/0x350
> [  563.266057]  addrconf_sysctl_disable+0x227/0x350
> [  563.266526]  ? dev_disable_change+0x130/0x130
> [  563.266965]  ? dev_disable_change+0x130/0x130
> [  563.267508]  ? _copy_from_user+0x8e/0xd0
> [  563.267951]  proc_sys_call_handler.isra.0+0x172/0x310
> [  563.268576]  ? proc_sys_lookup+0x2d0/0x2d0
> [  563.269041]  ? avc_policy_seqno+0x28/0x30
> [  563.269521]  ? lock_is_held_type+0xbb/0xf0
> [  563.269923]  vfs_write+0x159/0x350
> [  563.270261]  ksys_write+0xc9/0x160
> [  563.270609]  ? __ia32_sys_read+0x50/0x50
> [  563.270993]  ? ktime_get_coarse_real_ts64+0x103/0x120
> [  563.271467]  ? ktime_get_coarse_real_ts64+0xaa/0x120
> [  563.271938]  do_syscall_64+0x33/0x40
> [  563.272305]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  563.272789] RIP: 0033:0x7f6dd1c5faf7
> [  563.273141] Code: c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 fb fc ff ff 4c 89 e2 48 89 ee 89 df 41 89 c0 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 34 fd ff ff 48
> [  563.274705] RSP: 002b:00007fffe513d7b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  563.275363] RAX: ffffffffffffffda RBX: 0000000000000018 RCX: 00007f6dd1c5faf7
> [  563.275980] RDX: 0000000000000002 RSI: 00007fffe513d7e0 RDI: 0000000000000018
> [  563.276593] RBP: 00007fffe513d7e0 R08: 0000000000000000 R09: 00007fffe513d230
> [  563.277202] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
> [  563.277814] R13: 0000000000000018 R14: 0000000000000000 R15: 00007fffe513d7e0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200925184327.7257b6bb%40kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com.
