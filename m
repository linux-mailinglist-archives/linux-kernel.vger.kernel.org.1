Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6190D2FE899
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAULUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbhAULTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:19:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEC8B238E2;
        Thu, 21 Jan 2021 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611227948;
        bh=UteplEfvKjZ3XKQnqWZPIL99iTKbbBRViQieEN24DAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HA/XL6vL2j4eq1mzZyFSEyR3WC+kl1vK9V+b5oWG4ZGlafjMmMnaAC7DpzzsXmxdZ
         RHN6QdipPXibj1ZN/PPzxTjktHD+yP8uOsDQ4izUovj3o0oRXJSHr7JJQSoJUCjvWK
         D7ho/jSZR18hbwlcVJQfHohoo2DYKvBsIDQ6yZWYbzn18bwJDCTM6rSbx04UARh4vn
         8tTzykM63CZLW8Y7O3nMTzXcBk3PY9gIQ9/MM0rvPwVbbbKPcPveK3ZZ5qXvUoW6tX
         R5RaCV62QiRqZgNZF2Kxsno6oEH7z7WW45ib8hMMVvxWVagJT8ffy6lZ5f1geC+TBv
         jBr5GBLNfoBjw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2Xzf-0004lv-AR; Thu, 21 Jan 2021 12:19:15 +0100
Date:   Thu, 21 Jan 2021 12:19:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     SCHEMMEL Hans-Christoph <hans-christoph.schemmel@thalesgroup.com>
Cc:     Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: Adding support for Cinterion MV31
Message-ID: <YAljM0UUSFchrUWh@hovoldconsulting.com>
References: <PAYP264MB10254F44F1B0DA6A7797E78BAEA20@PAYP264MB1025.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAYP264MB10254F44F1B0DA6A7797E78BAEA20@PAYP264MB1025.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 12:49:02PM +0000, SCHEMMEL Hans-Christoph wrote:
> Adding support for Cinterion device MV31 for enumeration with PID 0x00B3 and
> 0x00B7.

Please resend this without using S/MIME encoding and remember to CC
linux-usb@vger.kernel.org

Try sending it to yourself first and make sure you can apply it using
git-am (this patch is corrupt, possibly due to the encoding).

There's some more info here:

	Documentation/process/email-clients.rst

Johan
