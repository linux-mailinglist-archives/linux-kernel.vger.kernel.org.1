Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC30302C26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhAYUBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:01:21 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:44124 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732140AbhAYT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:56:09 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 92EDF7A28;
        Mon, 25 Jan 2021 11:55:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 92EDF7A28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611604512;
        bh=L29mAEJ6cru7ET5XOlCC3ggXmPlpoV2+85bRSMdiplg=;
        h=To:Cc:From:Subject:Date:From;
        b=S6CxXpQSvNy8NqrOhoy/h5KNBWmu6n+d5AfZtm7SiNcpfaBpv+8hUsaKekM1Ige5A
         d4fU+FiQThCdABltwFjGQVhHvGvip/NURoplC3beMRM1mvxtHovAjxineunZhE+dp+
         DNs37mhdAgFamj6JXIaCoVwS+d1+ukFb/Mq1hve4=
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Subject: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
Date:   Mon, 25 Jan 2021 11:55:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.

Yet, various unofficial reports indicate it will be supported for 6 years.  And AOSP has already declared the use
of 5.10 kernel in their Android S and T releases.

Is there some way we could make the LTS support more clear.
A 2 year declaration is not LTS any more.
If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
https://www.kernel.org/category/releases.html

Regards,
 Scott






