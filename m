Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2634523D236
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 22:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHEUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 16:09:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56962 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHEQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:29:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3153987992;
        Wed,  5 Aug 2020 11:13:43 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=t4fVhjQVDWtzEETmfxy67PMJ+aE=; b=Xln+P+
        yxlSY/84uqmszJffyoR/qH2KB/720zEYc/zh05B9w6FYOZo4SNr9h8RIRD9YGwUd
        11XTHGNxdeatYBx7fwQRKn1KMzxfvb1+tEQj7ZOISPLsts5x+dWLdNJC25uO6khI
        B+/WIr6D7qtNubL+35i4I2hjOMe31sYeorLtc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28FEC87991;
        Wed,  5 Aug 2020 11:13:43 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Cvq6oQrzezpY4LxASPSDQy3sp0oeiiOQ+kGdMlRFHB4=; b=jZLFbTc4/NjzG+eJj6EfBs0AT33scg8HOgZvS0M5ev35O9kw6hCDbVnZHJr7GRhvS4AXf1ayxSbZqCUXBnU8mD4YbXbkqVt9Qtt48z1QSieFOrL5wCXG2xJOz2hMROcuo+zeGXbk7SKI2a7+E5OMeNcaERHPAyyuHU/tojg6Kvw=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 700B987990;
        Wed,  5 Aug 2020 11:13:42 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 380822DA0AA7;
        Wed,  5 Aug 2020 11:13:41 -0400 (EDT)
Date:   Wed, 5 Aug 2020 11:13:41 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Conor Culhane <conor.culhane@silvaco.com>
cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>
Subject: Re: [PATCH 3/4] i3c: master: svc: Add Silvaco I3C master driver
In-Reply-To: <BN6PR16MB1762D6CE430AB08B7A2BE5FCF14A0@BN6PR16MB1762.namprd16.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.77.849.2008051105550.1112668@knanqh.ubzr>
References: <20200709080159.2178-1-miquel.raynal@bootlin.com> <20200709080159.2178-3-miquel.raynal@bootlin.com>,<nycvar.YSQ.7.77.849.2008031546570.1112668@knanqh.ubzr> <BN6PR16MB1762D6CE430AB08B7A2BE5FCF14A0@BN6PR16MB1762.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 3FA9ABCE-D72E-11EA-93F8-2F5D23BA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020, Conor Culhane wrote:

> Miquel is passing 0 as the delay_us argument.

Good point.

> Is this still a concern?

Not in that case.


Nicolas
