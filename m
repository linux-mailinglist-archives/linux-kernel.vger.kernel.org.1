Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35BE1BD919
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD2KKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 06:10:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37732 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgD2KKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:10:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588155005; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=2mdlW9Q66AJBST1VWjfJfw3PhP2uQD6RM0aPJIOJ2Xg=; b=ZatmEfpD3Bsh8QryubtC4mP7Huo8BjQhW1fMtlsRmY8x8PVeQjmapR1kYrQT/eubPjz0BRK5
 gZR7J8jknXaGUwJ/MzYX+kVbXrpKkIlB+U5LOW68xKruDSRReFj66NjT1XK5M0vdFKVNvXQM
 wliILA6/W+ujkXXp2tNYhZ2VaaU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea9527a.7fef5d0e11f0-smtp-out-n04;
 Wed, 29 Apr 2020 10:10:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED255C43636; Wed, 29 Apr 2020 10:10:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D98A0C433CB;
        Wed, 29 Apr 2020 10:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D98A0C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Wed, 29 Apr 2020 15:39:53 +0530
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jan.kiszka@siemens.com, jasowang@redhat.com,
        christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429100953.GE5097@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200429055125-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-29 05:52:05]:

> > > So it seems that with modern Linux, all one needs
> > > to do on x86 is mark the device as untrusted.
> > > It's already possible to do this with ACPI and with OF - would that be
> > > sufficient for achieving what this patchset is trying to do?
> > 
> > In my case, its not sufficient to just mark virtio device untrusted and thus
> > activate the use of swiotlb. All of the secondary VM memory, including those
> > allocate by swiotlb driver, is private to it.
> 
> So why not make the bounce buffer memory shared then?

Its a limitation by our hypervisor. When a secondary VM is created, two
memory segments are allocated - one private and other shared. There is no
provision for the secondary VM to make part of its private memory shared after
it boots. I can perhaps consider a change in swiotlb driver to accept the second
shared memory segment as its main working area (rather than allocate its own).

That would still not work I think where swiotlb is used for pass-thr devices
(when private memory is fine) as well as virtio devices (when shared memory is
required).

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
