Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DEB2E7E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 08:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgLaHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 02:54:24 -0500
Received: from goshtv.com ([23.250.117.100]:49507 "EHLO goshtv.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgLaHyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 02:54:24 -0500
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Dec 2020 02:54:24 EST
Received: from [192.168.1.101] (cpe-75-85-175-189.san.res.rr.com [75.85.175.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robin@goshtv.com)
        by goshtv.com (Postfix) with ESMTPSA id 63C8D7A2DC1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 23:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinepaint.org;
        s=mail; t=1609401078;
        bh=2LM8mIoU6963zk33uGeoT3KEu9VcD5HdcCYNk3Uwqdo=;
        h=To:From:Subject:Date:From;
        b=au3L6l89ak7ANRIh1r+phcKHHiPPDwD2ObCQ9yej8+UNYanKHrFi3vEnmsqeuDpm1
         MpnZIQzL1pkzWUk+wkABTYF3EFCVFYUGe/VB8PBhyldOgs4tgdp1uzoFoP9QuCkH+j
         wRs23eH7/OeeLOGtsLaFcQREnDnptB2Be64Ff1yQ=
To:     LKML <linux-kernel@vger.kernel.org>
From:   Robin Rowe <robin.rowe@cinepaint.org>
Subject: C/C++ Code Reviewer Available
Message-ID: <beeedada-d62f-6a94-32aa-c4c56cfbe0a0@cinepaint.org>
Date:   Wed, 30 Dec 2020 23:45:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Linux kernel's Kroah-Hartman: We're not struggling to get new coders, 
it's code review that's the bottleneck", says article at The Register.

Ok, I've used C++ for 20 years, taught C/C++ at two universities, and 
developed real-time safety-critical systems. Need me? Contact me off-list.

Rob
-- 
Robin Rowe
CinePaint Project Manager
Beverly Hills, California

