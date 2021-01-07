Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1C2EC857
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbhAGCw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbhAGCw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:52:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BCFC0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 18:51:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so7692635ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LO5/Phbq28+31YDa1UZ1eQndglIwHyPOPdAo8T96Wc=;
        b=HQhQLnWS/ZJhdarKXSdd9H4qvqQ2V+N1W+bmCj0unK8v+b1kFb1bhI3HaS9/i50hzT
         kjnzni0TONbDtitbOV6IQqx+GH4UXTeabroXuypuTDDPupJ76lnHJOx66Ubp1AM2qBCP
         DdR/dJqziE60ULJpT4G1r7LtGQ4lkufUh1z85qvdRuzVd1H+YkUGZ32a4e6wu7cQF2AT
         qZI51OWODB4y0r+MMljmwvkatkq2Ym0xpyzFNmpM89mXs0bwDHxVo5YocIdmCoyUEgPk
         pn769EBOtvuoqxUfOSg3D7K1mvP8t0awPntTVNXSxKKzJka6xeC11b4yjF7HNVm95RtS
         ujHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LO5/Phbq28+31YDa1UZ1eQndglIwHyPOPdAo8T96Wc=;
        b=FuSO5bvjJWv/9lOdpoxRWfnDqsCSjLQAx2oXnfxiBWZh3ljHQ6dvpDWT0EAu/+Ulp5
         1qoZGjjhhnWRb+K07od+JDWnIK2ILz4EZda3mr+ravtcJYbwXQKIWXM+a2j794ARm2W9
         YcLlBjzG43kKgCEFq5oLJ9k+wJBwm8dW4wfL5gtUQ1r/niWZwkwC+c1wTNxqdp3i9G0C
         eCTH1g80CxFpBlAXvy8F30apq14930Lhl35Xj6Qwf2scKeO9YdQ+S6WsCWQ5jJI0Nmo0
         Cu87oFs3WXYN6/tWq4uAdvmY9pSc9qDF5S6MZFqiMRoofMdLHsfWJZLqFjMvfNa/BpML
         juHw==
X-Gm-Message-State: AOAM531H210C+weYqGMee9USdPlIqKBwfsX4PvQ7veBh0h35NcjZo48K
        ylIImMeQ5FyYw0evtnOOOmEtxGZumVdQXlm5EWM=
X-Google-Smtp-Source: ABdhPJzTIJZrgbwShljzLzrtpDr7Vf+8G5j4QQqhPuCnMXI9QmwqyOOOU6SGWBdt80TvLjY0rucjD3/iZWMmlgN8ZXw=
X-Received: by 2002:a17:906:417:: with SMTP id d23mr4922263eja.19.1609987904487;
 Wed, 06 Jan 2021 18:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20201223062412.343-1-zhenzhong.duan@gmail.com> <20210104190240.GF6029@char.us.oracle.com>
In-Reply-To: <20210104190240.GF6029@char.us.oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Thu, 7 Jan 2021 10:51:33 +0800
Message-ID: <CAFH1YnP5p0o+Ux9O_VXtx2QFYQjc16tzsR4txJdA8pm-WmtORQ@mail.gmail.com>
Subject: Re: [PATCH] x86/iommu: Fix two minimal issues in check_iommu_entries()
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, zhongjiang@huawei.com,
        joe@perches.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 3:04 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Wed, Dec 23, 2020 at 02:24:12PM +0800, Zhenzhong Duan wrote:
> > check_iommu_entries() checks for cyclic dependency in iommu entries
> > and fixes the cyclic dependency by setting x->depend to NULL. But
> > this repairing isn't correct if q is in front of p, there will be
> > "EXECUTION ORDER INVALID!" report following. Fix it by NULLing
> > whichever in the front.
> >
> > The second issue is about the report of exectuion order reverse,
> > the order is reversed incorrectly in the report, fix it.
>
> Heya!
>
> When you debugged this, did you by any chance save the
> serial logs and the debug logs to double-check it?

Hi Konrad,

The iommu_table_entry is sorted by sort_iommu_table() and
check_iommu_entries() finds nothing abnormal,
so there is no related logs to check.

Sorry for my poor english, I'm not saying there is order reverse, even
if there is, it will be repaired by sort_iommu_table(). Then
check_iommu_entries() report nothing.
What I mean is about check_iommu_entries() itself, below printk isn't correct.

printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
                               p->detect, q->detect);

Should be:

printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
                               q->detect, p->detect);

Regards
Zhenzhong
