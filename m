Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136DC21CC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 01:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgGLXjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 19:39:51 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:59170 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:39:51 -0400
Date:   Sun, 12 Jul 2020 19:39:48 -0400
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: Replace HTTP links with HTTPS ones
Message-ID: <20200712233944.GB14669@brightrain.aerifal.cx>
References: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
 <20200712111118.24916-1-grandmaster@al2klimov.de>
 <14fdab51-0197-1784-9ebb-356a0fd39952@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14fdab51-0197-1784-9ebb-356a0fd39952@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 06:30:04AM -0500, Rob Landley wrote:
> On 7/12/20 6:11 AM, Alexander A. Klimov wrote:
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
> 
> Trimmed just to the one site without the self-signed certficate: check.
> 
> > Deterministic algorithm:
> > For each file:
> >   If not .svg:
> >     For each line:
> >       If doesn't contain `\bxmlns\b`:
> >         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> >             If both the HTTP and HTTPS versions
> >             return 200 OK and serve the same content:
> >               Replace HTTP with HTTPS.
> > 
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> 
> Acked-by: Rob Landley <rob@landley.net>

Acked-by: Rich Felker <dalias@libc.org>

I agree about replacing just the one with working https, not the dead
self-signed one. Alexander, is this whole set being submitted upstream
through a single maintainer, or do you want me to take the arch/sh
patch individually?

Rich
