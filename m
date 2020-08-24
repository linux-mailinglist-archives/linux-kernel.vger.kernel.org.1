Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EEA24FBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgHXKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgHXKku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:40:50 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B18322067C;
        Mon, 24 Aug 2020 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265650;
        bh=0dOjMI4AN/7K1L0DukTXsv4PCx+hl7uJkoA2CUu5GNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mE2KhVyRbrL5EPy2o3MGbUoLJTOepU8e3+HX98BxXleFvvjJ1KPFyUXkWKYE76Ne9
         m5P5s9SjSlOCUAfrv2v1tJnhm6czt2AW69bO4hlvMFH1LXr5rJJ+HhkxffeVxhPKR/
         whYF8iETAqO3bl1HyaTrAW9k1U0OU8POzHQnWnnM=
Date:   Mon, 24 Aug 2020 18:40:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shengjiu.wang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mp: Update pinfunc header file
Message-ID: <20200824104036.GA12776@dragon>
References: <1597397239-2387-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597397239-2387-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 05:27:19PM +0800, Anson Huang wrote:
> Update some pins' name and adjust pin options to i.MX8MP pinfunc
> header file according to latest reference manual.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
