Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED12D316D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgLHRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgLHRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:45:27 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC5C061749;
        Tue,  8 Dec 2020 09:44:47 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 06735300;
        Tue,  8 Dec 2020 17:44:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 06735300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607449487; bh=oG12Gru0TWKaKYLTYRda9hx9kElGxv1mpYAZkjhKFp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kWHtTnVKktcaHjUlLXC5xIiV8/9J9lywjqV3Ek3fv68JA7OryeIqGrJx22FcZXeVP
         4L5XtFHjtCYqkfdxyAvlV74QDTrW7bX64IHMIDt5xy0+hT+K9oLXGWVGoUZULDMtV7
         xYzkZYrbiCcXfFdYl6ibO/RVNA1L4011KG23eB5zyt/9xhPsukZvNHSAItSEffF7nz
         P6zNc3vCGNjQPpTdQ5adVqx/b8+VWQ0MBIyUIxOoifdPmR+UEdUGAN9zZoAfqm0SfE
         OFgkV4kXBaYhDdOdeyG+z31iz08z0i1fJ/gJzXDXGSSepaTZiURY33zR3LCU2vq9xe
         OhTVSPNFVzJ0w==
Date:   Tue, 8 Dec 2020 10:44:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] New documentation text describing how to report
 issues (aka "reporting-bugs rewritten")
Message-ID: <20201208104445.0f82ae78@lwn.net>
In-Reply-To: <cover.1607063223.git.linux@leemhuis.info>
References: <cover.1607063223.git.linux@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Dec 2020 07:43:47 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> This series adds a new and mostly finished document describing how to report
> issues with the Linux kernel to its developers.

OK, I have applied this series.  Thanks to Thorsten for doing all of this
work and sticking with it, and thanks to the others (especially Randy) who
have spent a lot of time reviewing this work.

jon
