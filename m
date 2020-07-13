Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36021D19C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgGMIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGMIXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:23:07 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810482065D;
        Mon, 13 Jul 2020 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594628587;
        bh=Cc6XpKtFID0FHQDQzIyY1YoIHwf0PusCyNXYaHGbvkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkAMBzJ8hZD7trw7NLlfrXDIuyoHiUhDKNZRBO/SJw+7HnXjBE98dBtiH5DhA5MNn
         vx0bLMKwMJl1ZMA7u81j7Sas5gREJGEuWhRgOjjUDQsHYmeWJNj9wzyKIHrTV5L0Vx
         SgGrKQo85tsHT9bRP2zxc+Kn3F3BtlYibu86cHYE=
Date:   Mon, 13 Jul 2020 16:23:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     festevam@gmail.com, andrew@lunn.ch, s.hauer@pengutronix.de,
        stefan@agner.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: vf610-zii-dev-rev-c: Configure fiber port
 to 1000BaseX
Message-ID: <20200713082300.GO12113@dragon>
References: <20200708232501.6200-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708232501.6200-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 04:25:01PM -0700, Chris Healy wrote:
> The SFF soldered onto the board expects the port to use 1000BaseX.  It
> makes no sense to have the port set to SGMII, since it doesn't even
> support that mode.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.
