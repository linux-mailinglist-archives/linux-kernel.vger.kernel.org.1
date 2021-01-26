Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF0303F90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405600AbhAZOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:02:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405648AbhAZOBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:01:55 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631762255F;
        Tue, 26 Jan 2021 14:01:12 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l4Ou3-00A8ni-Ae; Tue, 26 Jan 2021 14:01:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jan 2021 14:01:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     mark.rutland@arm.com, leoyang.li@nxp.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        linux-arm-kernel@lists.infradead.org, ran.wang_1@nxp.com,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to
 remove call trace
In-Reply-To: <20210126110027.39689-1-biwen.li@oss.nxp.com>
References: <20210126110027.39689-1-biwen.li@oss.nxp.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <c0f1d3a6fcafebd226d53804ec0df0ed@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: biwen.li@oss.nxp.com, mark.rutland@arm.com, leoyang.li@nxp.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, linux-arm-kernel@lists.infradead.org, ran.wang_1@nxp.com, biwen.li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-26 11:00, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Add flag IRQCHIP_SKIP_SET_WAKE to remove call trace as follow,

[useless trace]

More importantly, what is the bug that you are fixing?

         M.
-- 
Jazz is not dead. It just smells funny...
