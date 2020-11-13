Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952112B18FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgKMKYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKMKYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:24:17 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7782B2224B;
        Fri, 13 Nov 2020 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605263056;
        bh=ZGh6WSwT91LdBj8NqYM8pLnycQEAmUxFUmkVbW1Te7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhSVaLk4Srl63vvSkOgatLFtnNdr/Rk4GTjyUQ/vdqOv+gae3sTmZBXKL8D+WxgH2
         5IzvNqSu4ELWrTp7JXDFBGWCI5edUBDbdvOx2HGSS5nMdKAJa/S+C13/NdW0egflsl
         UwR2t6GseY3wZruM0g3UqhERzpM/pXxaCQMjn2D0=
Received: by pali.im (Postfix)
        id 0159E723; Fri, 13 Nov 2020 11:24:13 +0100 (CET)
Date:   Fri, 13 Nov 2020 11:24:13 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add support for LED2
Message-ID: <20201113102413.tl734v47koqlq6r7@pali>
References: <20201006124455.16617-1-pali@kernel.org>
 <20201019080408.iv7vmj63cgt2i6vg@pali>
 <20201019122537.GN456889@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201019122537.GN456889@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 October 2020 14:25:37 Andrew Lunn wrote:
> On Mon, Oct 19, 2020 at 10:04:08AM +0200, Pali Rohár wrote:
> > Hello! Gregory, I would like to remind you following patch.
> 
> Hi Pali
> 
> Since the merge window is open at the moment, no new patches will be
> accepted until it closes.
> 
> You should resend once -rc1 is out.

Hello! -rc1 was already released. And as there are no new changes in
https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/
repository since I sent this patch, I guess that I resending it not
needed.
