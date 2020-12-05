Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA52CFBAD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 16:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgLEPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 10:00:00 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:36792 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgLEO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 09:56:34 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id ED40F2010FA;
        Sat,  5 Dec 2020 09:05:29 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id A49C820EC0; Sat,  5 Dec 2020 09:31:04 +0100 (CET)
Date:   Sat, 5 Dec 2020 09:31:04 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, olof@lixom.net,
        hch@lst.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pcmcia/electra_cf: Fix some return values in
 'electra_cf_probe()' in case of error
Message-ID: <X8tFSNBqbAY7caYN@light.dominikbrodowski.net>
References: <20200617195326.732863-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617195326.732863-1-christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Jun 17, 2020 at 09:53:26PM +0200 schrieb Christophe JAILLET:
> 'status' is known to be 0 at this point. It must be set to a meaningful
> value in order to return an error code if one of the 'of_get_property()'
> call fails.
> 
> Return -EINVAL in such a case.
> 
> Fixes: 2b571a066a2f("pcmcia: CompactFlash driver for PA Semi Electra boards")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pcmcia-next. Thanks!

	Dominik
