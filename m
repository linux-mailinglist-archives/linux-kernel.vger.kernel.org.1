Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3232A21CD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 05:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGMDP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 23:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMDP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:15:57 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85BD2068F;
        Mon, 13 Jul 2020 03:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610157;
        bh=YZzIW+KZpc0vqOCl/7oVkW5+VX1XWYHsXl9tcGS26FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xMmz1NIH59pJQvE4XDhJ3Kpk649kZPlGk9O7qg4Vuc1zWSWbssqppShAXVmmG/Hck
         oEo/vvn3AqVIwk96fgF3BLYIxapJ9KiQ5zv7Sr84cY4Wnd2RFEe87mJ18+bLKfuNM7
         I9Cam+LsrYGcHTdTyioj1bn0cagJT0JOvJ+/84aE=
Date:   Mon, 13 Jul 2020 11:15:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more thermal zone
 support
Message-ID: <20200713031551.GB21277@dragon>
References: <20200630032014.22956-1-andy.tang@nxp.com>
 <CAHLCerO3B4Z67KP8VaF957Jkid21gLvzhS49gNeqUC+6muPkjA@mail.gmail.com>
 <DBBPR04MB609085CD69E4CCBDD49CCF66F36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
 <CAP245DV-_+5Ht=yP9Mnzb2vUqXDJSEeBPfbNh48mEt62PmBeWA@mail.gmail.com>
 <DBBPR04MB60907EC06EAABC949DD42E3EF36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
 <CAP245DUzQBmKvg9oit8StKyfvp==eVZZ7dh0DUAwKkQnjSL_yw@mail.gmail.com>
 <DBBPR04MB6090001AA0A668A924EEB0FCF36D0@DBBPR04MB6090.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBPR04MB6090001AA0A668A924EEB0FCF36D0@DBBPR04MB6090.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:33:59AM +0000, Andy Tang wrote:
> Hi Shawn,
> 
> Do you think it is ok if the cooling devices are shared between thermal zones?

Yeah, Amit has the authority on thermal support, so follow his
suggestion, I would say :)

Shawn
