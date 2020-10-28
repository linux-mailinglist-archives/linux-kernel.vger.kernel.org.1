Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4129D3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgJ1Vqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:46:49 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57790 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ1Vqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:46:45 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id AD3F93B36C3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 10:59:06 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AD0CCFF81B;
        Wed, 28 Oct 2020 10:58:44 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     trix@redhat.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: remove unneeded break
Date:   Wed, 28 Oct 2020 11:58:43 +0100
Message-Id: <20201028105843.7404-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019191631.9604-1-trix@redhat.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 232b67c399424948107fbffe4402a102121a2622
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-19 at 19:16:31 UTC, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Acked-by: Richard Weinberger <richard@nod.at>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
