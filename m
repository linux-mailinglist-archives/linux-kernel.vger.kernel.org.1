Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38AD21E70F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 06:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgGNEkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 00:40:00 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53533 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgGNEkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 00:40:00 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B67221BF206;
        Tue, 14 Jul 2020 04:39:52 +0000 (UTC)
Date:   Mon, 13 Jul 2020 21:39:49 -0700
From:   josh@joshtriplett.org
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
Message-ID: <20200714043949.GB25423@localhost>
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
 <s5hlfjnzvu7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlfjnzvu7.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:02:24AM +0200, Takashi Iwai wrote:
> On Wed, 08 Jul 2020 20:14:27 +0200,
> Dan Williams wrote:
> > 
> > +Recommended replacements for 'blacklist/whitelist' are:
> > +    'denylist / allowlist'
> > +    'blocklist / passlist'
> 
> I started looking through the tree now and noticed there are lots of
> patterns like "whitelisted" or "blacklisted".  How can the words fit
> for those?  Actually, there are two cases like:
> 
> - Foo is blacklisted
> - Allow to load the non-whitelisted cards
> 
> Currently I'm replacing the former with "Foo is in denylist", but not
> sure about the latter case.  I thought Kees mentioned about this, but
> don't remember the proposal...

I find that "blocklist" works well as a verb: "foo is blocklisted",
"blocklist foo", or in some cases just "block foo" or "deny foo". For
the second case, phrasings like "allow loading non-safelisted cards" or
"allow loading cards not on the passlist" seem clear.
