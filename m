Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8754D24B13B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHTImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 04:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHTImT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:42:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3909220758;
        Thu, 20 Aug 2020 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597912938;
        bh=BnwApX3GfLjLBXFWCKh5pqgRomGQKD+9D+XuvrkyMhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGq8+izzRcwaFxVhVtneDvQKfpoHcfm820ArTm6bu4AhfivGgCYfPh7bEZhV+huAD
         hrIzAZrCCdM+m7aw6xqMAQE18RprUwD5dipgtbhK+k3uEq9mLmHvxp7xWZlhC7WM+C
         GwvntaHRzXJwWEYEmHXl7Au0fXhs3IqUfE2EOZAI=
Date:   Thu, 20 Aug 2020 10:42:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sven Schneider <s.schneider@arkona-technologies.de>
Subject: Re: [PATCH v2] lib/fonts: add font 6x8 for OLED display
Message-ID: <20200820084239.GB1001857@kroah.com>
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820082137.5907-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:21:37AM +0200, Sascha Hauer wrote:
> From: Sven Schneider <s.schneider@arkona-technologies.de>
> 
> This font is derived from lib/fonts/font_6x10.c and is useful for small
> OLED displays
> 
> Signed-off-by: Sven Schneider <s.schneider@arkona-technologies.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
