Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25FD218A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 16:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgGHOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 10:22:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37961 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729699AbgGHOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:22:56 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 068EMYIA016230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Jul 2020 10:22:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DFE2E420304; Wed,  8 Jul 2020 10:22:33 -0400 (EDT)
Date:   Wed, 8 Jul 2020 10:22:33 -0400
From:   tytso@mit.edu
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     corbet@lwn.net, Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
Message-ID: <20200708142233.GC1627842@mit.edu>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:23:59AM -0700, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
> 
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>

