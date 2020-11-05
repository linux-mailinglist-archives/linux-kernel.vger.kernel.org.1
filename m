Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1D2A80F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgKEObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:31:33 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:37322 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbgKEObd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:31:33 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kagIN-005Q6d-AL; Thu, 05 Nov 2020 15:31:23 +0100
Date:   Thu, 5 Nov 2020 15:31:23 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] tty: Remove obsolete drivers
Message-ID: <20201105143123.GL933237@lunn.ch>
References: <20201105123357.708813-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105123357.708813-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:33:55PM +0000, Lee Jones wrote:
> As per the vendor's request.
> 
> Lee Jones (2):
>   tty: Remove redundant synclink driver
>   tty: Remove redundant synclinkmp driver

Hi Lee

What exactly do you mean by redundant? That some other driver can be
used? Or that nobody uses the hardware any more? I know of one
deployed system which has some form of synclink card in use, but i
don't know which card in particular.

      Andrew
