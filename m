Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D4D22D7F7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 16:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgGYOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 10:08:03 -0400
Received: from mailomta30-sa.btinternet.com ([213.120.69.36]:43229 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbgGYOID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:08:03 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200725140800.FARW3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sat, 25 Jul 2020 15:08:00 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [86.152.161.91]
X-OWM-Source-IP: 86.152.161.91 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrheehgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepfdeolfhohhhnucfqlhgumhgrnheqfdcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecuggftrfgrthhtvghrnhepffevkeffkefffefhvedvveeiledvudeuvdetveeigfetteefffffkeeiudeikeevnecukfhppeekiedrudehvddrudeiuddrledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohephhgvnhhrhidpihhnvghtpeekiedrudehvddrudeiuddrledupdhmrghilhhfrhhomhepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoeguvghvvghlsegurhhivhgvrhguvghvrdhoshhuohhslhdrohhrgheqpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehguhhsthgrvhhosegvmhgsvgguuggvughorhdrtghomheqpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry (86.152.161.91) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5ED9AFBE088D266F; Sat, 25 Jul 2020 15:08:00 +0100
Date:   Sat, 25 Jul 2020 15:07:59 +0100
From:   "<John Oldman>" <john.oldman@polehill.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Subject: Re: [PATCH V2] Subject: [PATCH] staging: rtl8723bs: core: Using
 comparison to true is error prone
Message-ID: <20200725140759.GA15113@henry>
References: <20200725132806.15019-1-john.oldman@polehill.co.uk>
 <20200725133434.GA1143075@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725133434.GA1143075@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 03:34:34PM +0200, Greg KH wrote:
> On Sat, Jul 25, 2020 at 02:28:06PM +0100, John Oldman wrote:
> > clear below issues reported by checkpatch.pl:
> > 
> > CHECK: Using comparison to true is error prone
> 
> Your subject line is very odd :(

Thanks, I should read all before I send: I will re-send the patch.

> 
> > Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> > ---
> > v1: Initial attempt.
> > v2: Removed unneccessary parentheses around 'pregistrypriv->ht_enable'
> > Also considered clearing 'CHECK: Logical continuations should be on the previous line' report
> > but this results in exceeding line length guideline.
> >  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > index ca98274ae390..7aacbe1b763e 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > @@ -363,8 +363,9 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
> >  	}
> > 
> >  	/* HT Cap. */
> > -	if (((pregistrypriv->wireless_mode&WIRELESS_11_5N) || (pregistrypriv->wireless_mode&WIRELESS_11_24N))
> > -		&& (pregistrypriv->ht_enable == true)) {
> > +	if (((pregistrypriv->wireless_mode & WIRELESS_11_5N)
> > +	      || (pregistrypriv->wireless_mode & WIRELESS_11_24N))
> > +	      && pregistrypriv->ht_enable) {
> 
>  || and && go on the end of the line, not the front.
> 
> But you also changed other things that were not needed here, and you did
> not say that in your changelog text :(
> 
> thanks,
> 
> greg k-h
