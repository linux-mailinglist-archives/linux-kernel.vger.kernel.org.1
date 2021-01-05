Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0932EB2C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbhAESrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhAESrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:47:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B6C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:46:21 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c12so243564pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SNZVfIWKd37qkkuluejVnpuaXcVb0tUzeQd+fsRy+IQ=;
        b=Sya9EbW75MKED8LnBpNrd8mk7PYXd4wgZEgJkIHJxP5PIx2RfX9mmv4/yJLMpO1I2H
         8hEbv75X8/4JizHMC0Eebms5sug9C8tETWTkjxEJWkTpVD0QLAinlcyhfQ0na6aXUnY3
         heL2qOcFFqz/0jpsJw/gXjAuIG6ThoGwA0EsMUuUQMe3H0jwq23TJ3hNCDnPyx1Wzs4P
         5Am1bieNnlVTDUQHjm1K+mqTOsQmK/0ia1e1daoNejBpsgC2fu23efGLBS8mCDEXrY2y
         xkDVOTIp1zSQn1FrPt4g6uhKHfRE7aPkYDP7LagTTot5p/KwRxFF70mxs/kK/MZDkFWM
         RguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNZVfIWKd37qkkuluejVnpuaXcVb0tUzeQd+fsRy+IQ=;
        b=M9Evy9r2PYsblXMf377XcPYiC0TTroejpA/cnizrNBqVBAhaC2kY79HQV49sAQZ5Rh
         pcGirI/1wcuccNXeBQH/9Nfw8SQCZ8dhczu7NzMLx9aO5qOHGMtX933t3Lh7v47SzALu
         pZLkdxH4N2Dax83DYedWXpqh02J4prtdVEiYogCABQ/RNHEjRJPalK1iQkwdrg6Fun29
         zC4LVhEaKOx0ZuHyvsNPIGHBQw+CofjyBYoX5AtdwV86LiN7ZAT4sMI9+itvpti9AVab
         mwXaSyXrQrhdEQx5chqekKLpQtgoFTQWVRt33LkjEHof0JzyATyISkw0UTuKebMBlJpe
         Dyiw==
X-Gm-Message-State: AOAM5323a3iiklaSbYjs5x5nKs0sAVZ0O9z3VvdCCt7VCwh22jrCunsn
        ZbTNXA83ZbdQAxjQO82Px4ts7w==
X-Google-Smtp-Source: ABdhPJxPLtLy+4w4Yda8CaLzL1Zz0ILQQNIXP5BzeYA3N4xxinShgiNZl3jB9KiYZ44bcF7raVdSwA==
X-Received: by 2002:a63:5a08:: with SMTP id o8mr680896pgb.118.1609872380492;
        Tue, 05 Jan 2021 10:46:20 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id u11sm261441pjy.17.2021.01.05.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 10:46:19 -0800 (PST)
Date:   Tue, 5 Jan 2021 10:46:12 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, leohou1402 <leohou1402@gmail.com>,
        "maciej.szmigiero@oracle.com" <maciej.szmigiero@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "cannonmatthews@google.com" <cannonmatthews@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "pshier@google.com" <pshier@google.com>,
        "pfeiner@google.com" <pfeiner@google.com>,
        "junaids@google.com" <junaids@google.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "yulei.kernel@gmail.com" <yulei.kernel@gmail.com>,
        "kernellwp@gmail.com" <kernellwp@gmail.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: reproducible BUG() in kvm_mmu_get_root() in TDP MMU
Message-ID: <X/Sz9EN0cKbyd1gQ@google.com>
References: <4bf6fcae-20e7-3eae-83ec-51fb52110487@oracle.com>
 <8A352C2E-E7D2-4873-807F-635A595DCAEF@gmail.com>
 <CANgfPd_cbBxWHmPsw0x5NfKrMXzij3YAAiaq665zxn5nnraPGg@mail.gmail.com>
 <CANgfPd8fFB6QM3bOhxQ0WPjw6f5FLqBm1ynCenAxymByq4Lz5g@mail.gmail.com>
 <f360715b-e61b-7e68-1aa9-84df51331d95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f360715b-e61b-7e68-1aa9-84df51331d95@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021, Paolo Bonzini wrote:
> On 05/01/21 18:49, Ben Gardon wrote:
> > for_each_tdp_mmu_root(kvm, root) {
> >          kvm_mmu_get_root(kvm, root);
> >          <Do something, yield the MMU lock>
> >          kvm_mmu_put_root(kvm, root);
> > }
> > 
> > In these cases the get and put root calls are there to ensure that the
> > root is not freed while the function is running, however they do this
> > too well. If the put root call reduces the root's root_count to 0, it
> > should be removed from the roots list and freed before the MMU lock is
> > released. However the above pattern never bothers to free the root.
> > The following would fix this bug:
> > 
> > -kvm_mmu_put_root(kvm, root);
> > +if (kvm_mmu_put_root(kvm, root))
> > +       kvm_tdp_mmu_free_root(kvm, root);
> 
> Is it worth writing a more complex iterator struct, so that
> for_each_tdp_mmu_root takes care of the get and put?

Ya, and maybe with an "as_id" variant to avoid the get/put?  Not sure that's a
worthwhile optimization though.

On a related topic, there are a few subtleties with respect to
for_each_tdp_mmu_root() that we should document/comment.  The flows that drop
mmu_lock while iterating over the roots don't protect against the list itself
from being modified.  E.g. the next entry could be deleted, or a new root
could be added.  I think I've convinced myself that there are no existing bugs,
but we should document that the exact current behavior is required for
correctness.

The use of "unsafe" list_for_each_entry() in particular is unintuitive, as using
the "safe" variant would dereference a deleted entry in the "next entry is
deleted" scenario.

And regarding addomg a root, using list_add_tail() instead of list_add() in
get_tdp_mmu_vcpu_root() would cause iteration to visit a root that was added
after the iteration started (though I don't think this would ever be problematic
in practice?).
