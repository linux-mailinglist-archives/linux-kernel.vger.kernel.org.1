Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387072E910F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhADHbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:31:21 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:60450 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbhADHbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:31:21 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E5DFA2011A1;
        Mon,  4 Jan 2021 07:30:38 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id AFD7C20500; Mon,  4 Jan 2021 08:16:34 +0100 (CET)
Date:   Mon, 4 Jan 2021 08:16:34 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Switch to using the new API kobj_to_dev()
Message-ID: <X/LA0mrnbDmrL/nQ@light.dominikbrodowski.net>
References: <1609725570-11433-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609725570-11433-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Jan 04, 2021 at 09:59:30AM +0800 schrieb Tian Tao:
> fixed the following coccicheck:
> drivers/pcmcia/cistpl.c:1557:54-55: WARNING opportunity for kobj_to_dev()
> drivers/pcmcia/cistpl.c:1584:53-54: WARNING opportunity for kobj_to_dev()
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied to pcmcia-next, thanks!

	Dominik
