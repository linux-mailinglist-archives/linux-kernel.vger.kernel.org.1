Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB5276937
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIXGsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIXGsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:48:42 -0400
Received: from localhost (unknown [84.241.198.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C910420708;
        Thu, 24 Sep 2020 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600930121;
        bh=jBCz5LY8N9IUAfeiRv9iPCrY8XTkPMdC+ePT54L4hus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hS2Eq8O+EVxrHkBPgQTWfZykTFLAHV0mUNKvrxlV/zKqBQ2/+JwLoY3hQr7cHUP/t
         7dD8xopWl+BAxJ4mfGcMsIEItktj6mlIYpWAOZ5QWS9B33k+TFmVs5hxYgK21KjsXa
         IWGigLHjYo6QMVpXyH0JggfkprldBNpIHQgnPyvE=
Date:   Thu, 24 Sep 2020 08:48:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 1/9] misc: Add Surface Aggregator subsystem
Message-ID: <20200924064838.GB593984@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-2-luzmaximilian@gmail.com>
 <20200923165745.GA3732240@kroah.com>
 <de24d687-62c2-1f34-cac2-d32246c68a09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de24d687-62c2-1f34-cac2-d32246c68a09@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:34:23PM +0200, Maximilian Luz wrote:
> In short: Concurrent execution of the counter functions works, as far as
> I can tell at least, and, as you see by the long answer, I have to spend
> some time and think about the duplicate-value problem (again). If you've
> managed to read through this wall of text (sorry about that) and you
> have any ideas/preferences, please let me know.

No, this all answers my question really well, thanks, what you have now
is fine, no need to change it.

thanks,

greg k-h
