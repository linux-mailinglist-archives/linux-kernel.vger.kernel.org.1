Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181B91F2109
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFHUs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 16:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgFHUs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:48:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F57F206D5;
        Mon,  8 Jun 2020 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591649308;
        bh=238fOcqXeDGYuhV7gw64DtUgcBUvWxmcxIvosbMri3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAkS9snG+JFonK6Cr9qbLVSLdhrBTVAo4GP7dsTmgYJ0QrrOiPyVlYFu+/W9ELKYP
         gu/g6XTRBewCeD37ZLB44T0/4nYtVxxEYWfKJnL32NvEgU0JqZFdip2lhbA7hj+QOg
         tIFlBz8Ltn7MoKEW1P6rRtxo7SXlCOIwPGg2tIK4=
Received: by pali.im (Postfix)
        id 78CDBFB6; Mon,  8 Jun 2020 22:48:26 +0200 (CEST)
Date:   Mon, 8 Jun 2020 22:48:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     y.linux@paritcher.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
Message-ID: <20200608204826.kb7x5mh6hzj2hxcz@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
 <20200608090017.4qgtbosz7oullex2@pali>
 <8baab72e3d2e407792c3ffa1d9fffba8@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8baab72e3d2e407792c3ffa1d9fffba8@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 June 2020 15:46:44 Mario.Limonciello@dell.com wrote:
> I would actually question if there is value to lines in dell-wmi.c like this:
> 
> pr_info("Unknown WMI event type 0x%x\n", (int)buffer_entry[1]);
> 
> and
> 
> pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n", type, code);
> 
> In both of those cases the information doesn't actually help the user, by default it's
> ignored by the driver anyway.  It just notifies the user it's something the driver doesn't
> comprehend.  I would think these are better suited to downgrade to debug.  And if
> a key combination isn't doing something expected the user can use dyndbg to turn it
> back on and can be debugged what should be populated or "explicitly" ignored.

My motivation for these messages was to provide information to user that
kernel received event, but was not able to process it as it do not
understand it.

It could help in situation when user press special key and nothing is
delivered to userspace. But he could see that something happened in log.

Similar message is also printed by PS/2 keyboard driver atkbd.c:

	case ATKBD_KEY_UNKNOWN:
		dev_warn(&serio->dev,
			 "Unknown key %s (%s set %d, code %#x on %s).\n",
			 atkbd->release ? "released" : "pressed",
			 atkbd->translated ? "translated" : "raw",
			 atkbd->set, code, serio->phys);
		dev_warn(&serio->dev,
			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
			 code & 0x80 ? "e0" : "", code & 0x7f);
		input_sync(dev);
		break;
