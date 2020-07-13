Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9917721C4DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgGKPjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 11:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgGKPjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:39:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8287207D4;
        Sat, 11 Jul 2020 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594481975;
        bh=Kx3EXQ7sihkxDh9buhrzH1KfxXr4O1KN4BOW7ljxVKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fplH435InOk6jOvHtKcY9x0Blglpr8eitvoOfIvrildGkTcTE10jC0aE9hHNI+laa
         NEKnj9QbPXD6Q8ob4sJXOTDFW5Fj/qX6jBVJ61olVYWxaeMkNVrBdFi26Qdnu+zyed
         UaEZcXffAMvM2RvpDBZO99tah/fBVyBUPM23K/AA=
Date:   Sat, 11 Jul 2020 23:39:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     ran.wang_1@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [v3 2/4] arm64: dts: ls1028a: Add ftm_alarm0 DT node
Message-ID: <20200711153928.GM21277@dragon>
References: <20200624024501.15974-1-biwen.li@oss.nxp.com>
 <20200624024501.15974-2-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624024501.15974-2-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:44:59AM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The patch adds ftm_alarm0 DT node for LS1028ARDB board
> FlexTimer1 module is used to wakeup the system
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Applied, thanks.
