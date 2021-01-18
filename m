Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBAD2F9ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbhARHs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbhARHsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:48:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E8B22241;
        Mon, 18 Jan 2021 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610956064;
        bh=DWn4/rruNJFp+vFdTM0BgEvfEpBhIw9Mo5uNN5jgd2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFJqCcpPSn7/IIL1+MwS15xB6GTpWkmexMWXZpZGkGK1WLGFKdDagH9iGLOAZGsQX
         csGzF0Ybj3pOvaOau79vWXyLmhEkR3rjUUHFZ91IwNiV0hD8Ka2P9Rhql8AIU+a508
         JtPG0SHq+2elRfkc+saAjAADRCgUADEMZIr6zjxRHN1YZEwdVqUUZVEYE6WI3k9Ptj
         UshbRaiqD/DpuW+sLmTiRlhGb3xvdB58u6B2RTyadvBRtUG9V09C4pX8cOrNdfYJOf
         oRk2iaTgTKsqFWdj2H82ygkbQw9bfrytFgaQCwPdDiQ/tcZc7YOcoSBICfJGETrI2t
         Gxz9UPP5U3xgQ==
Date:   Mon, 18 Jan 2021 15:47:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] imx: select SOC_BUS to fix firmware build
Message-ID: <20210118074738.GT28365@dragon>
References: <20210116033259.31941-1-rdunlap@infradead.org>
 <AM6PR04MB49666F4A293420EF8E090E8B80A40@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49666F4A293420EF8E090E8B80A40@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 04:36:55AM +0000, Aisheng Dong wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > Sent: Saturday, January 16, 2021 11:33 AM
> > Subject: [PATCH] imx: select SOC_BUS to fix firmware build
> 
> Patch title probably is better to be:
> firmware: imx: xxxxx

Fixed it up and applied.
