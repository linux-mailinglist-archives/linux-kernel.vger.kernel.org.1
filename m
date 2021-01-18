Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87282F99EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbhARGaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732387AbhARG35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:29:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E142229C6;
        Mon, 18 Jan 2021 06:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610951347;
        bh=ZztTp0h19YciXh4fBHUKepWTeUFhZgGGWZqM1RAxO3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8iqDWcaIM1yG15GNsNKO4oIKIOUqtzi9YxaGUq7aKi2nG+ow7JM4sEk3ARGXGLFu
         6/p40dE+Bv4/F8DDMMSEW8Ay4BEFtkg4FeWDUZ6BEdjJt6yTBMhueKBBGBasH7Oe0o
         oZzHDQT1T1NRrPWGatdRNI/UU3ai4JTUIoQOgSvv7+4JDBj5SEOlqKL5tF+4kgN/sW
         iDX3tl6Y+smrZSjpNlsUaEdwmWfKOUgwTuskJobtKz6CYh+UFjeq210IMJBgKhDw/v
         YAaDFP/56AEdJkMi9vVK/Jfm3n/YYMJVxmQDgsrSmQZMb687NFYGHRAbAf0Cl3/6ZZ
         QCH6JftYxcVyw==
Date:   Mon, 18 Jan 2021 14:29:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND v3] arm64: dts: ls1028a: fix FlexSPI clock
Message-ID: <20210118062901.GI28365@dragon>
References: <20210111114555.28903-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111114555.28903-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:45:55PM +0100, Michael Walle wrote:
> Now that we have a proper driver for the FlexSPI interface use it. This
> will fix SCK frequency switching on Layerscape SoCs.
> 
> This was tested on the Kontron sl28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
