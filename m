Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C557819CE3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 03:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbgDCBlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 21:41:18 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17359 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389366AbgDCBlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585878067; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Dw59/79dQ/+JzjrxTuRueZQ5vqi5WEKEjdkB6YCSoySXp5RpbFUlRXw5ymn30pfGKx492atfkVCQmAXumkPbibm2qQ2Ol2hslY8t98SuktobZ0OX4oBn1Gf6qZo2LN8zieAraaizWvRF0Il0vcDzlPz5sCQNWXXtndAIgEawp0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585878067; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=a2E/ML9QEADhvjruGSmF/oci0J1Ogghj5dsuSj5L6U0=; 
        b=JrwvJ7xixVNDDJ5wrfwPNlxLl9o2EUalHCfUD8bGt09Ik+gCyRvHkWZTTpwQzABYIPmkv6Fgb+JvF3h05RrPcaTXZAcegXFXQEmV0NbhNVXwhCFWUMgepo+uBir/Jh20+eHHczq7DWTH3Se770rIhDKw84RMfg9ryfJLYZyv9Bk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585878067;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=a2E/ML9QEADhvjruGSmF/oci0J1Ogghj5dsuSj5L6U0=;
        b=pGuT63nBZlcAXOhB4HkGgt4LWumaW3GzSuIVZ3kEbGjiEqOD/9B0hQZui1QTiuz3
        AwrGWSCSshsxEQxy20E3odtExJ0iY69ZOQVIvsWmSRzGtazpdSH1HQR4EFtQCVFuMNO
        YSY6KEmSndDnt6RhA9utorZmq2cLTM9NZDjnybuY=
Received: from pop-os (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585878063281389.5278428735503; Thu, 2 Apr 2020 18:41:03 -0700 (PDT)
Date:   Thu, 2 Apr 2020 21:41:01 -0400
From:   Aiman Najjar <aiman.najjar@hurranet.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 0/5] staging: rtl8712: rtl871x_xmit.{c, h} code style
 improvements
Message-ID: <20200403014059.GA4077@pop-os.localdomain>
References: <cover.1585508171.git.aiman.najjar@hurranet.com>
 <20200402102906.GK2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402102906.GK2001@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dan for your review!!

On Thu, Apr 02, 2020 at 01:29:06PM +0300, Dan Carpenter wrote:
> Looks good.  Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 
