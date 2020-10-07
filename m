Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73E0286954
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgJGUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbgJGUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602103531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7J6dPwfXmeW22JZUNek6c2wKDKEBTY6RdTNBS6bcQ0=;
        b=Csxa8qDRJc7mZCQ+DceXFvzjT5or29gF4p9jzVOqldf+ZwiwiVVs5x/hSMkR5VXo6E1d+6
        MN5Kb/eG5TU85yEF0nPU+j15kM9s4lcOhE9YaPe1Xe6gdVifUOnQhigbEKG3sKZdFl1QGx
        RGgiRX2EVPbnNID9vftBEyOkzy89Vf4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Ej9ge3l8OO-7sa8JQwEBtg-1; Wed, 07 Oct 2020 16:45:29 -0400
X-MC-Unique: Ej9ge3l8OO-7sa8JQwEBtg-1
Received: by mail-qk1-f197.google.com with SMTP id 125so2232118qkh.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 13:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7J6dPwfXmeW22JZUNek6c2wKDKEBTY6RdTNBS6bcQ0=;
        b=OsoMQ8gRkl9cLChRTcBm5K11h35RM+L0H3rbO6xHfNAl6lnNWIPKQN++bJqde6WFQX
         gg0zRQUTzPDQLeGSM60vfF7V812Yv9zINKMHKrfqQ2+Bg0Nhk+6EFIH3d1hOKDNDTO0X
         s0Vhll+/xKw19M8N8/6m8SeUmrrDoBSgTR27kdERKDRomdnVvutuYk9EqUsSHDXcPzqH
         q+7Nzn37vLBv1sl4gp7i9XW/6jRe9Vy5qkDUx9Wr/u1UmdNcjADn4CH7SAELgZ8UFs8c
         nEWmbYJUkWCL7W2JK2StsGnGA/jQ3Md57vNueSNmlWyr91xWRsqPfY4rW6eqnXdLftcy
         BcXg==
X-Gm-Message-State: AOAM533x2+2+4ZPhFf+bDg06fsEkntMvVBlNLCejOW3dDj6AhFxRgisT
        Q7GXKUzyqV/a2HwUTR4RHb4jpqqbc9u92PWdTwfFMRNsen5I42jXWvx3L3A+H2VdUthJVkRfXJz
        fbfAT6QHbCPSIT+duBytdFqXj
X-Received: by 2002:a0c:b31c:: with SMTP id s28mr4943496qve.17.1602103528104;
        Wed, 07 Oct 2020 13:45:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnuEgrf9hFpVwG8HHk/TKC3qHYKhW63uYqNQX2cToA3cJ6Oxzipj8pV6tt+t/PfdunpV9t4Q==
X-Received: by 2002:a0c:b31c:: with SMTP id s28mr4943463qve.17.1602103527770;
        Wed, 07 Oct 2020 13:45:27 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id h4sm2376104qtq.41.2020.10.07.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 13:45:27 -0700 (PDT)
Date:   Wed, 7 Oct 2020 16:45:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Subject: Re: [KVM] 11e2633982: kernel-selftests.kvm.dirty_log_test.fail
Message-ID: <20201007204525.GF6026@xz-x1>
References: <20200930215449.48343-1-peterx@redhat.com>
 <20201004132631.GR393@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201004132631.GR393@shao2-debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 09:26:31PM +0800, kernel test robot wrote:
> # fetch 0x1fff3 page 13105==== Test Assertion Failure ====
> #   dirty_log_test.c:526: test_bit_le(page, bmap)
> #   pid=10583 tid=10583 - Invalid argument
> #      1	0x0000000000403294: vm_dirty_log_verify at dirty_log_test.c:523
> #      2	 (inlined by) run_test at dirty_log_test.c:743
> #      3	0x00000000004026f4: main at dirty_log_test.c:905 (discriminator 3)
> #      4	0x00007f2d11a2809a: ?? ??:0
> #      5	0x0000000000402809: _start at ??:?
> #   Page 131151 should have its dirty bit set in this iteration but it is missing

I think I reproduced this error even on my latest tree.  I don't think it's a
kvm bug, instead it's a bug in the test case.  Not too surprising considering
that I spent probably more time on the test case than the kernel changes.

KVM dirty ring introduced a chance for spurious dirty bit (safe, but it just
made the test even more tricky) which does not exist for dirty logging.  It
happens when the ring gets full and the last PFN written could be spurious,
simply because when kvm noticed that the ring is full, it won't continue the
guest (whose next instruction is to do the real RAM update) but instead it'll
quit to userspace with that page PFN actually set but with old data.

The current test case is very strict on checking stuff. It tries to skip this
magic bit so far by recording it into host_bmap_track so we don't check the
data in this round, but we expect this bit to be set in the next run (because
it's the next guest instruction that gonna happen soon).  However I just
noticed that when accidentally the vcpu thread didn't really continue (e.g.,
when the collection thread is too slow, due to when we enabled all debug
prints) then we won't find that special bit in the next iteration of dirty
bitmap simply because the vcpu has already stopped and never go into the next
round.

Anyway, I'm posting the fix here for reference which have worked for me.  Below
is the thing I plan to squash into the test patch (probably not the current
one, but previous one):

-------------8<--------------------
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 80c42c87265e..aecd0f99f13c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -146,6 +146,20 @@ static sem_t dirty_ring_vcpu_cont;
  * dirty_ring_vcpu_stop and before vcpu continues to run.
  */
 static bool dirty_ring_vcpu_ring_full;
+/*
+ * This is only used for verifying the dirty pages.  Dirty ring has a very
+ * tricky case when the ring just got full, kvm will do userspace exit due to
+ * ring full.  When that happens, the very last PFN is very tricky in that it's
+ * set but actually the data is not changed (the guest WRITE is not really
+ * applied yet), because when we find that the dirty ring is full, we refused
+ * to continue the vcpu, hence we got the dirty gfn recorded without the new
+ * data.  For this specific case, it's safe to skip checking this pfn for this
+ * bit, because it's a redundant bit, and when the write happens later the bit
+ * will be set again.  We use this variable to always keep track of the latest
+ * dirty gfn we've collected, so that if a mismatch of data found later in the
+ * verifying process, we let it pass.
+ */
+static uint64_t dirty_ring_last_page;

 enum log_mode_t {
        /* Only use KVM_GET_DIRTY_LOG for logging */
@@ -281,7 +295,8 @@ static uint32_t dirty_ring_collect_one(struct kvm_dirty_gfn *dirty_gfns,
                TEST_ASSERT(cur->offset < num_pages, "Offset overflow: "
                            "0x%llx >= 0x%x", cur->offset, num_pages);
                pr_info("fetch 0x%x page %llu\n", *fetch_index, cur->offset);
-               set_bit(cur->offset, bitmap);
+               set_bit_le(cur->offset, bitmap);
+               dirty_ring_last_page = cur->offset;
                dirty_gfn_set_collected(cur);
                (*fetch_index)++;
                count++;
@@ -572,16 +587,12 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
                                         *    (here if we read value on page
                                         *     "2R-2" is 1, while iter=3!!!)
                                         */
-                                       matched = true;
-                               } else {
+                                       continue;
+                               } else if (page == dirty_ring_last_page) {
                                        /*
-                                        * This is also special for dirty ring
-                                        * when this page is exactly the last
-                                        * page touched before vcpu ring full.
-                                        * If it happens, we should expect the
-                                        * value to change in the next round.
+                                        * Please refer to comments in
+                                        * dirty_ring_last_page.
                                         */
-                                       set_bit_le(page, host_bmap_track);
                                        continue;
                                }
                        }
-------------8<--------------------

Majorly what I did is:

  - A new variable 'dirty_ring_last_page' is introduced to the test to record
    the last dirtied GFN.  When verifying the dirty bits, if we found a
    spurious dirty bit on this specific GFN, we skip.  This should be more
    solid than the previous trick to pass it onto host_bmap_track.

  - Since at it, I touched up two other places:

    - Replaced another set_bit() that I just found, which would otherwise break
      ppc I believe (but I must also confess I don't know when ppc will support
      dirty ring)

    - Change one "matched = true;" into a "continue;".  It should do the same
      thing, but "continue" is more obvious.

I'll resend the series.  I won't touch anything else, but just to (hopefully)
trigger the testbot again on the whole series.

-- 
Peter Xu

