Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F236922C88C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGXO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:56:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53848 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgGXO4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:56:09 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jyz7H-006gr8-0b; Fri, 24 Jul 2020 16:56:07 +0200
Date:   Fri, 24 Jul 2020 16:56:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luka Kovacic <luka.kovacic@sartura.hr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: Re: [PATCH 3/4] arm: mvebu: dts: Add CRS328-4C-20S-4S board
Message-ID: <20200724145607.GE1594328@lunn.ch>
References: <20200724103840.18994-1-luka.kovacic@sartura.hr>
 <20200724103840.18994-4-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724103840.18994-4-luka.kovacic@sartura.hr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:38:39PM +0200, Luka Kovacic wrote:
> MikroTik CRS328-4C-20S-4S board has a switch chip with an integrated
> Marvell Prestera 98DX3236 CPU.
> 
> This commit includes two board variants, namely the factory
> default one and a Bit variant. The Bit variant has a
> bigger Macronix flash.
> 
> This device tree includes basic Linux support.
> 
> Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Jakov Petrina <jakov.petrina@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
