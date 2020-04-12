Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3F1A60B8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 23:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgDLVgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 17:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgDLVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 17:36:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD62C0A3BF5;
        Sun, 12 Apr 2020 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3dkvE6ZHszlHKvVSJdUI9CLngjrTEQE78ymtYwts5h0=; b=M6r5CW6h4kpeGnZIRJBcYBIhmi
        WaFhWaV69rTIgUsE/t3ex3KjlxH+DIgZ2kvvvZV4JsJ/5U6COyQrOTEzzkbROKOPN7cklbbMGpmja
        MvWImPgcarhrpBb49pemG3PI/HdhJs0AC5/kQ1Y/3EIrLCpOx3xbj21SiSH5i+b2HGSQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jNkHC-002K1r-90; Sun, 12 Apr 2020 23:36:26 +0200
Date:   Sun, 12 Apr 2020 23:36:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tqmx86: Fix a typo in MODULE_DESCRIPTION
Message-ID: <20200412213626.GC547517@lunn.ch>
References: <20200412213047.4827-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412213047.4827-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 11:30:47PM +0200, Christophe JAILLET wrote:
> Based on the file name and code of the driver, it is likely that this
> module is related to TQMx86 and not TQx86.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
