Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6B2A3723
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKBXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgKBXZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:25:07 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C5222268;
        Mon,  2 Nov 2020 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604359507;
        bh=3TtxzP1XXB7ODonsz+f88fuMvxDxMLyNaVRq92wCyTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI0WZwO9qQldE8t7JC3BR8A9LiJOO3nlH2ckDJCnE+HxIUFqszsZsq8+Ew4diVRDw
         4SWYEeaI6ilTYSxSC4460ty4ExID62sWuIdysO1wNwIdX4YWBI9l/vtXE5Tg110Hjf
         OugD2N8jpVR+X00xhpxQzZTX9TAp/jrxwJgeYjHg=
Date:   Tue, 3 Nov 2020 07:25:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     meenakshi.aggarwal@nxp.com
Cc:     robh+dt@kernel.org, V.sethi@nxp.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add device tree support for LX2162AQDS board
Message-ID: <20201102232501.GS31601@dragon>
References: <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
 <1604296781-28295-1-git-send-email-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604296781-28295-1-git-send-email-meenakshi.aggarwal@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:29:39AM +0530, meenakshi.aggarwal@nxp.com wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> LX2162A has same die as of LX2160A with different packaging.
> 
> Changes:
> 
>         v2:
>         - divided patch into two, binding and dts support
> 
> 	v3:
> 	- incorporated review comments on voltage regulator node
> 
> 	v4:
> 	- fixed check-patch warning.
> 
> Meenakshi Aggarwal (2):
>   dt-bindings: arm64: add compatible for LX2162A QDS Board
>   arm64: dts: lx2160a: add device tree for lx2162aqds board

Applied both, thanks.
