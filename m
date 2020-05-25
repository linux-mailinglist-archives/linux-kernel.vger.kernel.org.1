Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5C1E12DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388820AbgEYQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbgEYQnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:43:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6DAC061A0E;
        Mon, 25 May 2020 09:43:15 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A57104A2;
        Mon, 25 May 2020 16:43:14 +0000 (UTC)
Date:   Mon, 25 May 2020 10:43:13 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: security: core.rst: add missing
 argument
Message-ID: <20200525104313.0d163ea5@lwn.net>
In-Reply-To: <20200525103310.455f50e0@lwn.net>
References: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
        <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
        <20200525103310.455f50e0@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 10:33:10 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Fri, 15 May 2020 20:39:17 -0400
> Ben Boeckel <me@benboeckel.net> wrote:
> 
> > From: Ben Boeckel <mathstuf@gmail.com>
> > 
> > This argument was just never documented in the first place.
> > 
> > Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> > ---
> >  Documentation/security/keys/core.rst | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)  
> 
> Applied, thanks.

...or not...looks like David got there first.  Sorry for the noise.

jon
