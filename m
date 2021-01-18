Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435E72F9A17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbhARGqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbhARGqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:46:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF21229C4;
        Mon, 18 Jan 2021 06:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610952320;
        bh=e2CwknkP5NekTSXTF/l/DZ4TRNU3wjDFJ3Y0S399E/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qc0rbu5xpn0EJ6RO51eVoTq+WbllSP+2LtQE2RIYxGKhj5b/MbSejWjOhrw0dXctQ
         7gwgV7Cccqv6uT4chqmcNXokjJRuJBq5G5pwqJbhwolYMJoyOj6UXOX2nxwAX9i7RA
         viZQzv2za7nW9ckLdzszW136/CAzNC6DZ+4nWHFJenBZwf5Dz7QKgnrEa9M79e8Lzb
         O+iHIPC550pu0BRRzR5lQe0r6punn+RNFA8Lk0JOKxD7c4hwqWYSMsLMNFZseXbNpq
         o/GQmXYJajmQpceaiqwEnf2Zw7/SEQzE2X3J1B1DQNY67syP6WHt7H9XU3mWBwqEX2
         sNHqQkEum/0OQ==
Date:   Mon, 18 Jan 2021 14:45:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] ARM: imx: build suspend-imx6.S with arm instruction
 set
Message-ID: <20210118064512.GK28365@dragon>
References: <20210111151704.26296-1-max.krummenacher@toradex.com>
 <20210111151704.26296-2-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111151704.26296-2-max.krummenacher@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:17:04PM +0100, Max Krummenacher wrote:
> When the kernel is configured to use the Thumb-2 instruction set
> "suspend-to-memory" fails to resume. Observed on a Colibri iMX6ULL
> (i.MX 6ULL) and Apalis iMX6 (i.MX 6Q).
> 
> It looks like the CPU resumes unconditionally in ARM instruction mode
> and then chokes on the presented Thumb-2 code it should execute.
> 
> Fix this by using the arm instruction set for all code in
> suspend-imx6.S.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Applied, thanks.
