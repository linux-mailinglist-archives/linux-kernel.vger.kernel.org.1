Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8521D27D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 11:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgGMJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 05:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgGMJHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:07:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885012067D;
        Mon, 13 Jul 2020 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594631264;
        bh=7RDrk6FG1G62GPqsHxzurTUGskSxu5+1OFflYhbzKfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wOT8AHtzzgyRADfUKlrv52LaBGhO1mBFbzszcivm6jdBYuJ7EbOvOP2ZDplnA4l7x
         zw2leXdjl+XbajHinafbdMEH459thNFRjtODBci3fa6u/6+JhSHMJNN+U8dEDGBQcp
         5BJ1s290BEjlogTfLpqWYgBY9BoYOx82tSUYI3zM=
Date:   Mon, 13 Jul 2020 17:07:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     s.hauer@pengutronix.de, stefan@agner.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, horia.geanta@nxp.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4] ARM: dts: vfxxx: Add node for CAAM
Message-ID: <20200713090738.GJ15718@dragon>
References: <20200711020245.6056-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711020245.6056-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:02:45PM -0700, Chris Healy wrote:
> From: Andrey Smirnov <andrew.smirnov@gmail.com> 
> 
> Add node for CAAM device in NXP Vybrid SoC.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> v4:
> - really add reviewed by from Fabio Estevam
> v3:
> - put version information in the correct place
> - add reviewed by from Fabio Estevam

I have picked up v2 with all these fixed up.

Shawn
