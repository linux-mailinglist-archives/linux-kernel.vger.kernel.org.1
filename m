Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE802D4CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbgLIVPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:15:23 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:50002 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387924AbgLIVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:15:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id B7CBCB42;
        Wed,  9 Dec 2020 22:14:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IyGpdNaeq0Nx; Wed,  9 Dec 2020 22:14:20 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 0D2E0ABE;
        Wed,  9 Dec 2020 22:14:20 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kn6mx-006kS2-1r; Wed, 09 Dec 2020 22:14:19 +0100
Date:   Wed, 9 Dec 2020 22:14:19 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/3] speakup: Add synth parameter to io functions
Message-ID: <20201209211419.5waw2q6o35s67ncw@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20201130220626.854574234@ens-lyon.org>
 <20201130220719.168900798@ens-lyon.org>
 <X9Dh3exc0rN1YitF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9Dh3exc0rN1YitF@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le mer. 09 déc. 2020 15:40:29 +0100, a ecrit:
> On Mon, Nov 30, 2020 at 11:26:41PM +0100, Samuel Thibault wrote:
> > This merely adds the missing synth parameter to all io functions.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> This patch breaks the build :(
> 
> Can you rebase and resend this whole series, as the other patches do not
> apply anymore due to the recent fixes in the speakup code.

Ok, I rebased and resent.

Samuel
