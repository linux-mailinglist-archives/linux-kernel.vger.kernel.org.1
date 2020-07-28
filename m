Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFF231476
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgG1VMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 17:12:40 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:44948 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgG1VMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:12:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 4C691A209;
        Tue, 28 Jul 2020 23:12:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 70bZpSPXe8IG; Tue, 28 Jul 2020 23:12:36 +0200 (CEST)
Received: from function.home (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id B764AA1EC;
        Tue, 28 Jul 2020 23:12:36 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k0Wto-002tqN-42; Tue, 28 Jul 2020 23:12:36 +0200
Date:   Tue, 28 Jul 2020 23:12:36 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/speakup: Update TODO list
Message-ID: <20200728211236.nf3jrp7m2nq7diwi@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
References: <20200726165452.qhos3wrjcm6jmcmx@function>
 <20200728081842.GA1648133@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728081842.GA1648133@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le mar. 28 juil. 2020 10:18:42 +0200, a ecrit:
> On Sun, Jul 26, 2020 at 06:54:52PM +0200, Samuel Thibault wrote:
> > Thanks to Okash's latest work, the TODO list is essentially empty, so
> > the way out from staging now seems open.
> > 
> > The status of the remaining issue mentioned in TODO is not clear, we
> > asked the speakup user mailing list for reproducer cases, but didn't get
> > a really specific scenario. One serious bug was fixed by 9d32c0cde4e2
> > ("staging/speakup: fix get_word non-space look-ahead"), which does not
> > seem to really be related to the bug mentioned in TODO. Possibly the bug
> > mentioned in TODO has been fixed long ago and people have been thinking
> > that it was not because they can not distinguish the symptoms mentioned
> > in TODO from the symptoms of the bug fixed by 9d32c0cde4e2.
> 
> I think it's time we move speakup out of staging.  Care to submit a
> patch series that does this?

Yes!

Done so.

Samuel
