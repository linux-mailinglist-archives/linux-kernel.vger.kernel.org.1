Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC02492C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 04:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHSCJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 22:09:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37395 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHSCJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:09:07 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200819020903epoutp03a905826be8557252bbe67146cf5e3c50~siU-Do3Cm1253412534epoutp03b
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 02:09:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200819020903epoutp03a905826be8557252bbe67146cf5e3c50~siU-Do3Cm1253412534epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597802943;
        bh=kxbo7eMgrK3SBvMvlw7cM5qlajMPHGPiUFNSCKIGvZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ff8ctMz7mHT6Hov/3OsBzOUh0n5phfoDsae+pmZ42N3YIXZaZDZbNsHgj2b+WGr3W
         jThvtfDyRAbb28THWE+tM2xSm8zt7XpffWXomWzgbRXl4kWoV75ZLJISwxpa/fQA8S
         fns5Htsk2DEpwXOV7PAWo9znB9JuF2rp716yV53I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200819020901epcas2p456f4f40ee45dcf83af820f0cc78a918b~siU9N99ZT1684716847epcas2p4G;
        Wed, 19 Aug 2020 02:09:01 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.187]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BWWRb44FszMqYkr; Wed, 19 Aug
        2020 02:08:59 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.9B.27013.BB98C3F5; Wed, 19 Aug 2020 11:08:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819020857epcas2p1681b773d1393c7c29a8bc61606061922~siU54uxFS0037000370epcas2p1A;
        Wed, 19 Aug 2020 02:08:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200819020857epsmtrp1991dcb6deeb4dc6574e8836dc5a6d310~siU5zoEM11046710467epsmtrp1D;
        Wed, 19 Aug 2020 02:08:57 +0000 (GMT)
X-AuditID: b6c32a48-d35ff70000006985-29-5f3c89bbeff8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.FE.08382.9B98C3F5; Wed, 19 Aug 2020 11:08:57 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819020857epsmtip181371babb51b8fd6987480a92a18d0a4~siU5qibAQ0856508565epsmtip1g;
        Wed, 19 Aug 2020 02:08:57 +0000 (GMT)
Date:   Wed, 19 Aug 2020 11:01:26 +0900
From:   Cho KyongHo <pullip.cho@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Will Deacon <will@kernel.org>, janghyuck.kim@samsung.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200819020121.GA70898@KEI>
MIME-Version: 1.0
In-Reply-To: <20200818161006.GA25124@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmme7uTpt4g10tshbvl/UwWpyesIjJ
        4m/nBVaLBfutLTbPKbbY9Pgaq8XlXXPYLA5+eMJq0XLH1IHTY828NYwem1doeWxa1cnmsXlJ
        vcfkG8sZPfq2rGL0+LxJLoA9KscmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BoWGBXnFi
        bnFpXrpecn6ulaGBgZEpUGVCTsajF50sBd38FZcnd7A0MC7j6WLk5JAQMJF4e24KaxcjF4eQ
        wA5GiUWLjzNBOJ8YJR73zGGBcL4xSnz/c5oVpuXRjcVQLXsZJbafWsAMkhASeMgo8fVeKIjN
        IqAqcWjNXTYQm01AS2L13OOMILaIgKbEreXtzCDNzALvGCVa+i6zgCSEBbwl1qxoZgKxeQU0
        JHqnHWOEsAUlTs58AlbDKWAssWreJ6DNHByiAioSrw7Wg8yREOjlkHi4eB4jSFxCwEVi7jZ1
        iEOFJV4d38IOYUtJvOxvY4eon84o8W7+ITaIxGZGiW+7BSFsY4lZz9rB9jILZEi0HXvDDjFT
        WeLILRaIMJ9Ex+G/UGFeiY42IYhOFYmdU6+xwKzq23uDBaLEQ+LvRCFI6Oxkkvj2XnMCo/ws
        JH/NQrILwtaRWLD7E9ssoG5mAWmJ5f84IExNifW79Bcwsq5iFEstKM5NTy02KjBBjupNjOD0
        quWxg3H22w96hxiZOBgPMUpwMCuJ8PbutY4X4k1JrKxKLcqPLyrNSS0+xGgKjKWJzFKiyfnA
        BJ9XEm9oamRmZmBpamFqZmShJM77zupCnJBAemJJanZqakFqEUwfEwenVANTuP/JY5McNov3
        aLXPzuHvPLBDsaX76gPnLVwSgp8tHGckFMlKNLVZRiw+8snK20C7XMXt4D6uLbkaS0KP2Mhz
        Tvm7cIIHj/Yjk+3nurj+7U6VXMvFcGPJtqqesl0xLO9PSEpK6H5seB33bLp8VhB3Vc3pv9ty
        c3/bzFwhtEKs5s7lVMXUzk2ZbkvDstMDHq6wylxy9snPWPH7Zm8q5t5QjtXbOql32bJlIdlP
        /u5aZrlSqCZ534uvm5jXPmzgjp+S94GbIf9e+XkzH7HNmlu+yUfGmXVear1tZRe2mFFMv1At
        ufsht/brmzu7ObxD/Pb+2Lxh0czm1i+6Ph8/dBwp+LT4kOqnowErPzpNLHdSYinOSDTUYi4q
        TgQAeJorQzgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO7OTpt4gxlrDSzeL+thtDg9YRGT
        xd/OC6wWC/ZbW2yeU2yx6fE1VovLu+awWRz88ITVouWOqQOnx5p5axg9Nq/Q8ti0qpPNY/OS
        eo/JN5YzevRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfG3vaCgtM8FQtnvmFpYPzP2cXIySEh
        YCLx6MZi1i5GLg4hgd2MEj1N21kgElIS87rXMkHYwhL3W45AFd1nlPhy9zxYgkVAVeLQmrts
        IDabgJbE6rnHGUFsEQFNiVvL25lBGpgF3jFKtPRdBpsqLOAtsWZFM1gzr4CGRO+0Y4xQq5kk
        GtqmskAkBCVOznwCZjMDTb3x7yVQAweQLS2x/B8HSJhTwFhi1bxPrCBhUQEViVcH6ycwCs5C
        0jwLSfMshOYFjMyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI0RLcwfj9lUf9A4x
        MnEwHmKU4GBWEuHt3WsdL8SbklhZlVqUH19UmpNafIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILU
        IpgsEwenVANTxXSme748B6a+9GfN+Pr4amq1ccLFeqb69pvncl9bl5xjaM/qKjCOdemrkajz
        f2pT5KoZxnf1YXV1wMwjmxLZb722XfPm0f34rQ8bf1vfbXI8NoNz0Xx9w0nRfO4mh1gyvQzO
        73pzfnJS1UXt8Mj3rxQOXo8LERdSDpssmFW/RT0h6+ycOeIRb9etqxZm/Xg69sY9m4a/oR4e
        DKl8vh/5iwOvJBh1P+HqetMruuLfJquk63OnLP1mvpZtksaEe99u71n7co8Yn9ZET3bNzp9L
        p7l+vhRX+Tqj7LPxP3FP7fb50VvOXd6sxfs/Yc7Kn9YTMp7tnpRwrP/T21mbfvG06Z6oZZke
        f9JHtyhO4SKvEktxRqKhFnNRcSIADimrgP8CAAA=
X-CMS-MailID: 20200819020857epcas2p1681b773d1393c7c29a8bc61606061922
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----wn.C777VfLFf0j4dI6teQ5O7yZ9hP4.it_WB71vmM7CNsG.7=_30f47_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
        <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
        <20200818082852.GA15145@willie-the-truck> <20200818093739.GB191752@KEI>
        <20200818100756.GA15543@willie-the-truck>
        <20200818161006.GA25124@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------wn.C777VfLFf0j4dI6teQ5O7yZ9hP4.it_WB71vmM7CNsG.7=_30f47_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Aug 18, 2020 at 05:10:06PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 11:07:57AM +0100, Will Deacon wrote:
> > > > so I'm not sure
> > > > that we should be complicating the implementation like this to try to
> > > > make it "fast".
> > > > 
> > > I agree that this patch makes the implementation of dma API a bit more
> > > but I don't think this does not impact its complication seriously.
> > 
> > It's death by a thousand cuts; this patch further fragments the architecture
> > backends and leads to arm64-specific behaviour which consequently won't get
> > well tested by anybody else. Now, it might be worth it, but there's not
> > enough information here to make that call.
> 
> So it turns out I misread the series (*cough*, crazy long lines,
> *cough*), and it does not actually expose a new API as I thought, but
> it still makes a total mess of the internal interface.  It turns out
> that on the for cpu side we already have arch_sync_dma_for_cpu_all,
> which should do all that is needed.  We could do the equivalent for
> the to device side, but only IFF there really is a major benefit for
> something that actually is mainstream and matters.
> 
Indeed, arch_sync_dma_for_cpu_all() is used where the new internal API
arch_sync_barrier_for_cpu() should be called. I just thought it is a
special hook for MIPS.
In the next version of the patch series, I should consider using
arch_sync_dma_for_cpu_all() and introducting its 'for_dev' version with
some performance data to show the benefit of the change.

Thank you for the proposal.

KyongHo

------wn.C777VfLFf0j4dI6teQ5O7yZ9hP4.it_WB71vmM7CNsG.7=_30f47_
Content-Type: text/plain; charset="utf-8"


------wn.C777VfLFf0j4dI6teQ5O7yZ9hP4.it_WB71vmM7CNsG.7=_30f47_--
