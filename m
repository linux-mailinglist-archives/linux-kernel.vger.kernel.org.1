Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEA29CBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374858AbgJ0W1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:27:01 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36557 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374850AbgJ0W1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:27:00 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DA4FB22FB3;
        Tue, 27 Oct 2020 23:26:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1603837618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhQZ6qZ9RvERhK0/FOn0nWDX9oV7/yBunnJMLi68+SY=;
        b=XhoKeqJ6fA6IxkZ1u6sclV1ef80OMhKM+xuDOu/2xwNgQC6Y6CCeny5Fn1ZIq8ntpx1lmd
        9o3HF3NpuDjPugWP30Q9P8xI/I7Y4Wx8+PFN0UK44e5fyEpljoqC8K3N4LScT3Qe8zjMlW
        DCxuO/bvFue2/6nFu16sCwO07xQhDYY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Oct 2020 23:26:55 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v5 0/3] mtd: spi-nor: keep lock bits if they are
 non-volatile
In-Reply-To: <20201003153235.29762-1-michael@walle.cc>
References: <20201003153235.29762-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <babd96f5018d6081746aa9063ce21756@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-10-03 17:32, schrieb Michael Walle:
> I bundled this as a series, because otherwise there will be conflicts
> because the "remove global protection flag" patches modify the same 
> lines
> as the main patch.
> 
> See invdividual patches for the version history.

any news here?

-michael
