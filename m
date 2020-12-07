Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DA2D0EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgLGLLA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 06:11:00 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57005 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgLGLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:11:00 -0500
Received: from xps13 (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4D3BF240016;
        Mon,  7 Dec 2020 11:10:17 +0000 (UTC)
Date:   Mon, 7 Dec 2020 12:10:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] mtd: spinand: micron: Generalize the structure
 names
Message-ID: <20201207121016.3b6d986b@xps13>
In-Reply-To: <20201108113735.2533-2-nthirumalesha7@gmail.com>
References: <20201108113735.2533-1-nthirumalesha7@gmail.com>
        <20201108113735.2533-2-nthirumalesha7@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thirumalesha,

Thirumalesha Narasimhappa <nthirumalesha7@gmail.com> wrote on Sun,  8
Nov 2020 19:37:34 +0800:

> Rename the read/write/update of SPINAND_OP_VARIANTS() to a generic names

I applied this patch with a minor change: it's not a generalization of
the name, but quite the opposite.

Thanks,
Miquèl
