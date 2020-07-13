Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF93421D981
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgGMPGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 11:06:54 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33838 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729844AbgGMPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:06:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C81808EE2A2;
        Mon, 13 Jul 2020 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594652812;
        bh=Wv28Q89o7zHc6Vbye8fvipuLhXUbfn/tNh6dihLUgYo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vj+10LYgvpVxNV9mMHAIMEKUcWsvjvWTiCRT2Rc4m2JcWnKIBuHWwKXmcOSeUUSB0
         qhfLGQC0oyEWNdy3sXjvAiZV+zsO56kgfmlTqeIwMK9hjiGkF7K+kF9YBYT6JIPtl8
         U8UwpMMyjSHTiLyPKQ18A+/rfrsdNFJXA8xXCqes=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IwuWQz25J0Fo; Mon, 13 Jul 2020 08:06:52 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1758B8EE051;
        Mon, 13 Jul 2020 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594652812;
        bh=Wv28Q89o7zHc6Vbye8fvipuLhXUbfn/tNh6dihLUgYo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vj+10LYgvpVxNV9mMHAIMEKUcWsvjvWTiCRT2Rc4m2JcWnKIBuHWwKXmcOSeUUSB0
         qhfLGQC0oyEWNdy3sXjvAiZV+zsO56kgfmlTqeIwMK9hjiGkF7K+kF9YBYT6JIPtl8
         U8UwpMMyjSHTiLyPKQ18A+/rfrsdNFJXA8xXCqes=
Message-ID: <1594652811.3750.7.camel@HansenPartnership.com>
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] [PATCH v3] CodingStyle:
 Inclusive Terminology
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 13 Jul 2020 08:06:51 -0700
In-Reply-To: <s5hlfjnzvu7.wl-tiwai@suse.de>
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
         <s5hlfjnzvu7.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-13 at 10:02 +0200, Takashi Iwai wrote:
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

Remember these are suggestions for going forwards, not requirements for
changing everything.  We tend to be a community that likes make work
projects because they're easier to do than solving the hard problems,
but since we have over 100k occurrences of the various words in the
kernel, changing them all would cause massive churn and disrupt forward
development, which would cause way more harm than any gain from the
change.

James



