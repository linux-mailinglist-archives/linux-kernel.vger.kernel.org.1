Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0642D5F91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbgLJPZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:25:18 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:57336 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgLJPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:24:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 8D7ECCF7;
        Thu, 10 Dec 2020 16:24:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id duy2vdE50n8e; Thu, 10 Dec 2020 16:24:11 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id D0E95CF6;
        Thu, 10 Dec 2020 16:24:11 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1knNne-009ptZ-DX; Thu, 10 Dec 2020 16:24:10 +0100
Date:   Thu, 10 Dec 2020 16:24:10 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/3] speakup: Add synth parameter to io functions
Message-ID: <20201210152410.xwmpludozj2vklio@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20201209205829.693745475@ens-lyon.org>
 <20201209205838.531299374@ens-lyon.org>
 <X9I9Xwh+Q3tHXh88@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9I9Xwh+Q3tHXh88@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le jeu. 10 déc. 2020 16:23:11 +0100, a ecrit:
> On Wed, Dec 09, 2020 at 09:58:30PM +0100, samuel.thibault@ens-lyon.org wrote:
> > This merely adds the missing synth parameter to all io functions.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> 
> The build still breaks when this patch is applied:

?? I'll have to check

> You can't break the build on any patches in a series :(

Sure ! In my tests the build passes fine without any warning at each
patch...

Samuel
