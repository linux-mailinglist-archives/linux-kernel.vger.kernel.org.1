Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A174E2FF9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbhAVBH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAVBHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:07:24 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6082C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:06:43 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y19so7992237iov.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jK8dGzMF5fbkHysShjPpwKhS3UG4E9WXSfnT0AJszwQ=;
        b=adhZ9HBXkbT+OuB9xzLZ9RRrVOVOPOEKdTg2Pm8YXBo1SbP8GpmN3yjunxBX64DmRk
         1ISzXA8OG0M8EUJyexOgolPcEn/gLG5nBfmqme/9y39kYbcptdc/eE+K0pLmNCwJyiTR
         h9U0PEonaW+FRLZ73pZK8Zn+o2kShgEkgZAr6eAZRAHxfJJbA87OBMzaYX78aX+uB2b5
         QHTsmG2UwmcOqbagC5woensCE+lUuDnfCbcr+K3veMO8jdSXw6FlO5vf6DZCyXX+PuUk
         h3qiP/VVrw2lFMITdzwyS7n0hrJ1GVI9TjFdS7tBuMvWwFPrK7kg4ynL/pDh4U/MLcBq
         hVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jK8dGzMF5fbkHysShjPpwKhS3UG4E9WXSfnT0AJszwQ=;
        b=McV0QVKnUotjq+KUSl3jrmN/7Yydz5HqH2xZmruhJvlS9ulWBaN83kzynn2G7GLrms
         0fLCO3Jt2VSzfWFWujUqME/1SWyvxKNXvzyIxW3ojcqStMnKuvRM7gck67rrOFAO2jpG
         azIw066rWx4lUj6fo2HjNW+mMv4yOQtvAsVtxReYd8QGw9OPvT16JOTkSb8gb7Mh2Qj6
         Ks/NQAWR9LlrY5Xy5MlYO8DiMJ5wVAzVO9nWCHavg3Dg7xM/ZO1hoPbMGTswcGk2dibT
         P86syG0/kLJY8rzpVVekBkl54IZWL7VCQwp7AExVlH5iY/t/UTDssasjqQCF2JrVwziP
         hEsA==
X-Gm-Message-State: AOAM532fVuQzuJFQwfTVewwh4V2UHI+neSOWEyIBsuo4N0ohLldEZGNC
        Jh5XNlWN7Eupr7kWZzz4wOBOPXLJU0+HArN1RZrl8Q==
X-Google-Smtp-Source: ABdhPJxXHOmQM989K1wKwQNiDXpujO4EfvfcYbPwYYEr8Y52N1cCIseWfyEtac/XGEZXUWJM0hozVHGrsbsU+Ghn0zY=
X-Received: by 2002:a92:15c6:: with SMTP id 67mr1929319ilv.283.1611277602645;
 Thu, 21 Jan 2021 17:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com> <20210112181041.356734-6-bgardon@google.com>
 <YAiEaB/t/o9JvRN4@google.com>
In-Reply-To: <YAiEaB/t/o9JvRN4@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 21 Jan 2021 17:06:31 -0800
Message-ID: <CANgfPd8vPUVF4Rp695nmQWzWCbyCV8dE6uAbw-KVXE9uirYvfQ@mail.gmail.com>
Subject: Re: [PATCH 05/24] kvm: x86/mmu: Fix yielding in TDP MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:28 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jan 12, 2021, Ben Gardon wrote:
> > There are two problems with the way the TDP MMU yields in long running
> > functions. 1.) Given certain conditions, the function may not yield
> > reliably / frequently enough. 2.) In some functions the TDP iter risks
> > not making forward progress if two threads livelock yielding to
> > one another.
> >
> > Case 1 is possible if for example, a paging structure was very large
> > but had few, if any writable entries. wrprot_gfn_range could traverse many
> > entries before finding a writable entry and yielding.
> >
> > Case 2 is possible if two threads were trying to execute wrprot_gfn_range.
> > Each could write protect an entry and then yield. This would reset the
> > tdp_iter's walk over the paging structure and the loop would end up
> > repeating the same entry over and over, preventing either thread from
> > making forward progress.
> >
> > Fix these issues by moving the yield to the beginning of the loop,
> > before other checks and only yielding if the loop has made forward
> > progress since the last yield.
>
> I think it'd be best to split this into two patches, e.g. ensure forward
> progress and then yield more agressively.  They are two separate bugs, and I
> don't think that ensuring forward progress would exacerbate case #1.  I'm not
> worried about breaking things so much as getting more helpful shortlogs; "Fix
> yielding in TDP MMU" doesn't provide any insight into what exactly was broken.
> E.g. something like:
>
>   KVM: x86/mmu: Ensure forward progress when yielding in TDP MMU iter
>   KVM: x86/mmu: Yield in TDU MMU iter even if no real work was done
>
> > Fixes: a6a0b05da9f3 ("kvm: x86/mmu: Support dirty logging for the TDP MMU")
> > Reviewed-by: Peter Feiner <pfeiner@google.com>
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  arch/x86/kvm/mmu/tdp_mmu.c | 83 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 69 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index b2784514ca2d..1987da0da66e 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -470,9 +470,23 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
> >                         gfn_t start, gfn_t end, bool can_yield)
> >  {
> >       struct tdp_iter iter;
> > +     gfn_t last_goal_gfn = start;
> >       bool flush_needed = false;
> >
> >       tdp_root_for_each_pte(iter, root, start, end) {
> > +             /* Ensure forward progress has been made before yielding. */
> > +             if (can_yield && iter.goal_gfn != last_goal_gfn &&
>
> Make last_goal_gfn a property of the iterator, that way all this logic can be
> shoved into tdp_mmu_iter_flush_cond_resched(), and the comments about ensuring
> forward progress and effectively invalidating/resetting the iterator (the
> comment below) can be a function comment, as opposed to being copied everywhere.
> E.g. there can be a big scary warning in the function comment stating that the
> caller must restart its loop if the helper yielded.
>
> Tangentially related, the name goal_gfn is quite confusing.  "goal" and "end"
> are synonyms, but "goal" is often initialized with "start", and it's not used to
> terminate the walk.  Maybe next_gfn instead?  And maybe yielded_gfn, since
> last_next_gfn is pretty horrendous.

All these are excellent suggestions and definitely make the code
cleaner. I'll definitely adopt yielded_gfn. While I agree goal_gfn is
a little odd, I think next_gfn could be more misleading because the
goal_gfn is really more of a target than the next step. It might take
4 or 5 steps to actually reach a last-level entry mapping that gfn.
target_last_level_gfn or next_last_level_gfn would probably be the
most accurate option.

>
> > +                 tdp_mmu_iter_flush_cond_resched(kvm, &iter)) {
>
> This isn't quite correct, as tdp_mmu_iter_flush_cond_resched() will do an
> expensive remote TLB flush on every yield, even if no flush is needed.  The
> cleanest solution is likely to drop tdp_mmu_iter_flush_cond_resched() and
> instead add a @flush param to tdp_mmu_iter_cond_resched().  If it's tagged
> __always_inline, then the callers that unconditionally pass true/false will
> optimize out the conditional code.
>
> At that point, I think it would also make sense to fold tdp_iter_refresh_walk()
> into tdp_mmu_iter_cond_resched(), because really we shouldn't be mucking with
> the guts of the iter except for the yield case.
>
> > +                     last_goal_gfn = iter.goal_gfn;
>
> Another argument for both renaming goal_gfn and moving last_*_gfn into the iter:
> it's not at all obvious that updating the last gfn _after_ tdp_iter_refresh_walk()
> is indeed correct.
>
> You can also avoid a local variable by doing max(iter->next_gfn, iter->gfn) when
> calling tdp_iter_refresh_walk().  IMO, that's also a bit easier to understand
> than an open-coded equivalent.
>
> E.g. putting it all together, with yielded_gfn set by tdp_iter_start():
>
> static __always_inline bool tdp_mmu_iter_cond_resched(struct kvm *kvm,
>                                                      struct tdp_iter *iter,
>                                                      bool flush)
> {
>         /* Ensure forward progress has been made since the last yield. */
>         if (iter->next_gfn == iter->yielded_gfn)
>                 return false;
>
>         if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
>                 if (flush)
>                         kvm_flush_remote_tlbs(kvm);
>                 cond_resched_lock(&kvm->mmu_lock);
>
>                 /*
>                  * Restart the walk over the paging structure from the root,
>                  * starting from the highest gfn the iterator had previously
>                  * reached.  The entire paging structure, except the root, may
>                  * have been completely torn down and rebuilt while we yielded.
>                  */
>                 tdp_iter_start(iter, iter->pt_path[iter->root_level - 1],
>                                iter->root_level, iter->min_level,
>                                max(iter->next_gfn, iter->gfn));
>                 return true;
>         }
>
>         return false;
> }
>
> > +                     flush_needed = false;
> > +                     /*
> > +                      * Yielding caused the paging structure walk to be
> > +                      * reset so skip to the next iteration to continue the
> > +                      * walk from the root.
> > +                      */
> > +                     continue;
> > +             }
> > +
> >               if (!is_shadow_present_pte(iter.old_spte))
> >                       continue;
> >
