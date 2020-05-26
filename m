Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0251AC962
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409655AbgDPPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:22:45 -0400
Received: from saul.pp3345.net ([163.172.111.124]:52988 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898519AbgDPNpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:45:38 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id 039279A4640;
        Thu, 16 Apr 2020 15:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1587044700; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=XFpSBwsComldpKaI1pOqVCUGFWWRy6at6PB2RGEFAXU=;
        b=LtxyhaVmGMB3UPcLDdWG15/UYkPFRQbtdWpVvTzyz4iKNFXQL4NPAJEd38xV+9nWHmCFxk
        iCA4x3XsC/tNc/lamZVXrM3F1YKu6/rddcAxtrxbY0/ZyoddJIzE/RRMQez8MjusD0Nppt
        bN6FD0UOFaHoBsc/tMULMTZ1unPo0DaaL/SsxCY6kgdusMq8bMi59ULbS5KWVIKhtgdJWl
        FdVS1qQDrricyclJ6pe0+Eq2xTR7MjLsnXsQLMBXwBTtOLlicOVxvpZHgrTLhY6DFlTorP
        X4VpkjwvqWKJZKfWRBsl5gPXeTNaC6XoejVRM4DQ4knNylwgSOrivtNjaOfWvg==
Message-ID: <35ab8ba55f661cb8fd3ee65322e790421b65ef53.camel@pp3345.net>
Subject: Re: [PATCH 5/5] drm/i915: Replace "Broadcast RGB" with "RGB
 quantization range" property
From:   Yussuf Khalil <dev@pp3345.net>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Simon Ser <contact@emersion.fr>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Date:   Thu, 16 Apr 2020 15:44:53 +0200
In-Reply-To: <20200415111336.GZ3456981@phenom.ffwll.local>
References: <20200413214024.46500-1-dev@pp3345.net>
         <20200413214024.46500-6-dev@pp3345.net>
         <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr>
         <87ftd6mi3e.fsf@intel.com> <87d08amhy5.fsf@intel.com>
         <20200414123404.GT3456981@phenom.ffwll.local>
         <2cfe44c96818515939050ad19e9c248e50519be2.camel@pp3345.net>
         <87r1wp5hkq.fsf@intel.com> <20200415111336.GZ3456981@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-15 at 13:13 +0200, Daniel Vetter wrote:
> On Wed, Apr 15, 2020 at 10:33:25AM +0300, Jani Nikula wrote:
> > On Tue, 14 Apr 2020, Yussuf Khalil <dev@pp3345.net> wrote:
> > > On Tue, 2020-04-14 at 14:34 +0200, Daniel Vetter wrote:
> > > > On Tue, Apr 14, 2020 at 02:21:06PM +0300, Jani Nikula wrote:
> > > > > On Tue, 14 Apr 2020, Jani Nikula <jani.nikula@linux.intel.com
> > > > > >
> > > > > wrote:
> > > > > > On Mon, 13 Apr 2020, Simon Ser <contact@emersion.fr> wrote:
> > > > > > > On Monday, April 13, 2020 11:40 PM, Yussuf Khalil <
> > > > > > > dev@pp3345.net> wrote:
> > > > > > > 
> > > > > > > > DRM now has a globally available "RGB quantization
> > > > > > > > range"
> > > > > > > > connector
> > > > > > > > property. i915's "Broadcast RGB" that fulfils the same
> > > > > > > > purpose is now
> > > > > > > > considered deprecated, so drop it in favor of the DRM
> > > > > > > > property.
> > > > > > > 
> > > > > > > For a UAPI point-of-view, I'm not sure this is fine. Some
> > > > > > > user-
> > > > > > > space
> > > > > > > might depend on this property, dropping it would break
> > > > > > > such
> > > > > > > user-space.
> > > > > > 
> > > > > > Agreed.
> > > > > > 
> > > > > > > Can we make this property deprecated but still keep it
> > > > > > > for
> > > > > > > backwards
> > > > > > > compatibility?
> > > > > > 
> > > > > > Would be nice to make the i915 specific property an "alias"
> > > > > > for
> > > > > > the new
> > > > > > property, however I'm not sure how you'd make that happen.
> > > > > > Otherwise
> > > > > > juggling between the two properties is going to be a
> > > > > > nightmare.
> > > > > 
> > > > > Ah, the obvious easy choice is to use the property and enum
> > > > > names
> > > > > already being used by i915 and gma500, and you have no
> > > > > problem.
> > > > > Perhaps
> > > > > they're not the names you'd like, but then looking at the
> > > > > total
> > > > > lack of
> > > > > consistency across property naming makes them fit right in.
> > > > > ;)
> > > > 
> > > > Yeah if we don't have contradictory usage across drivers when
> > > > modernizing
> > > > these properties, then let's just stick with the names already
> > > > there.
> > > > It's
> > > > not pretty, but works better since more userspace/internet
> > > > howtos
> > > > know how
> > > > to use this stuff.
> > > > -Daniel
> > > 
> > > Note that i915's "Broadcast RGB" isn't the same as gma500's: i915
> > > has an
> > > "Automatic" option, whereas gma500 does not.
> > 
> > Adding "Automatic" option that just defaults to "Full" in gma500
> > does
> > not break existing userspace, but allows for extending it to do
> > more
> > clever things later.
> 
> gma500 could keep it's own property, without the "Automatic" value.
> We've
> done tricks like this for other properties too.
> 
> > > Also, radeon has a property called
> > > "output_csc" that fulfills a similar purpose. Looking at the
> > > code, though, it
> > > seems that radeon does not adhere to the standard correctly (or I
> > > am missing
> > > something).
> > > 
> > > An alternative would be to leave the existing driver-specific
> > > properties and
> > > change them to be pseudo-aliases for the "RGB quantization range"
> > > property.
> > > This can be done by letting the drivers read from and write to
> > > the new property
> > > when user-space tries to read or modify the driver's property.
> > > This way we could
> > > retain full backwards compatibility for all drivers equally.
> > > 
> > > What do you think?
> > 
> > I'm obviously biased and predisposed to avoid adding extra
> > complexity to
> > i915 when it's not necessary. We'd have *two* connector properties
> > for
> > the same thing until the end of time, even if one is an alias for
> > the
> > other.
> 
> Yeah just pick one, and implement the others as aliases. Drivers can
> do
> the aliases in their atomic_get/set_property functions pretty easily,
> atomic properties aren't stored anywhere else than decoded (which was
> done
> partially to make stuff like this work).
> 
> Coming up a new property name just so that everyone suffers equally
> feels
> silly.
> -Daniel

Okay, I understand your point. Leaving gma500 without a proper implementation of
the "Automatic" value isn't an option though as that would break the whole
purpose of this patchset: having a property that works precisely the same way
across all drivers. I'll build a patch that implements standards-compliant
behavior for gma500 then, so that it can use the same property as the others.

Regards
Yussuf

