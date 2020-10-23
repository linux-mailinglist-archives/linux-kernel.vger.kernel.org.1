Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68D1297699
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbgJWSMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754503AbgJWSMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:12:47 -0400
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA712072E;
        Fri, 23 Oct 2020 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603476766;
        bh=OjLr1mjuq4UW5kNHNZYNXdgGdSLN3kRdIP1BVQsC4ck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ef+p6HEEvPVo8v5QngBIAQhYkX0qhEejADO+VT1v5R9lNejGuZzL+2nXL4uRbXl6X
         bmDz1nepqOG3vQQc9NEca/UPFa2RZxX8+NeCPW09aPDYFzro/xOKMuVOukSy7KSb6G
         ALbrP8MkbDP0/YzIBU+vrz00kf4r1ZLHTg7GSdPc=
Date:   Fri, 23 Oct 2020 11:12:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Antti Palosaari <crope@iki.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Borislav Petkov <bp@alien8.de>,
        Chris Leech <cleech@redhat.com>,
        Colin Cross <ccross@android.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Lee Duncan <lduncan@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Matt Porter <mporter@kernel.crashing.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org
Subject: Re: [PATCH v3 00/56] Fix several bad kernel-doc markups
Message-ID: <20201023111240.2cc72568@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 18:32:47 +0200 Mauro Carvalho Chehab wrote:
> @maintainers: feel free to pick the patches and
> apply them directly on your trees, as all patches on 
> this series are independent from the other ones.

Sorry Mauro, can I hassle you for resending 18-20 as a separate series
or just loose patches to netdev?

We got a bunch of checks run on all submissions and when folks CC only
a slice of a series to netdev the CI bot thinks the series is incomplete
and doesn't pick it up :(
