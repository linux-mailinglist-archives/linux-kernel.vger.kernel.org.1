Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E341C2D4285
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgLIM6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:58:15 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:60480 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgLIM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:58:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 53227123AE9;
        Wed,  9 Dec 2020 13:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607518652;
        bh=ivF8UJQ0nui932gV7q+Vx2HM88wGiAXI70k+UaqYnrU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=PPNKSqb6FpgDz2BmOzUXUni7OeVA4JZxo6uI514lRRGgY9Jd0R9cyxzjTMVLfTuiP
         na3T0GbihpYNEENJtGKNT7UcTxqLOvtQwm7TKEuqX2ku8Nl53N/VjnyMB+1al4cKjq
         sFY5/1SBcZAjpxPZKAYCNOvg4p0RfjQnuhlLK2tvcDXuxlGgq7k9GMjNfeJKkPUyrd
         H/yGKlmAGySbNCYOgxk2IufcxZshRnVQtb+I3/R5LD1ze3QEkD4PEs0N0tn+Uw52ls
         +WalycZJDmCpN4tKg0jFGVG7dfkJenVxMAOy1S03m4Jyasy4HVv7kiMltMh7zXoueN
         rr30V18rJa0Zg==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RDXvmWuXYQHT; Wed,  9 Dec 2020 13:57:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 4C36B123AE6;
        Wed,  9 Dec 2020 13:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607518623;
        bh=ivF8UJQ0nui932gV7q+Vx2HM88wGiAXI70k+UaqYnrU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=cfinZCwIbNmxAOze+m8ZQUZAsQy7wCGf5RfieLwS+iS5NS9/1AG7qaGXdAgGEJA/T
         ykKpZMUyfIrLmfBytZmj+0LetGeaMVfuYW5y8eTthiihh43jq+JG0ShvQY1ys4rxfH
         D0bRfwcQxHsnAINKYT6908aZGoD5KMisuzCfOKT7IPycHY2uui/qTFMVwS0lY+U1id
         VUti51SE672XlwgPZ4sVXPktdJ+ZKBht8Np19l9uDor67FNHJR17VxRiWZYaO4aMsu
         M4//6zd20e0zPHg0/uG1Niuduf7zHaflIyFFDDt70jEZg7gBh8mIuezzIS6fihsrs3
         6LrPGdfqcdXQw==
From:   "Info" <info@ministro.hu>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>
References: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAAAJUqiRO33GQqGIHffCVyG/AQAAAAA=@ministro.hu> <X9C8zlCMvTev7ELE@kroah.com>
In-Reply-To: <X9C8zlCMvTev7ELE@kroah.com>
Subject: RE: ***UNCHECKED*** Re: [PATCH] Staging: silabs si4455 serial driver
Date:   Wed, 9 Dec 2020 13:57:01 +0100
Message-ID: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAADw4WwGItHrQ5iFlvxJ/JFMAQAAAAA=@ministro.hu>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJyKQPHehkkfqd9+nsH6keBxU1MfAGA7sq/qKvzxgA=
Content-Language: hu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 09, 2020 at 12:09:58PM +0100, Info wrote:
> > This is a serial port driver for
> > Silicon Labs Si4455 Sub-GHz transciver.
> >=20
> > Signed-off-by: J=C3=B3zsef Horv=C3=A1th <info@ministro.hu>
>
> Note, your From: line does not match this line, so I can't take this.
>
> But:
>
> > ---
> >  .../bindings/staging/serial/silabs,si4455.txt |   39 +

I'll fix this, sorry.

>
> staging drivers need to be self-contained, so this should be here.  It =
needs to be reviewed by the DT maintainers when moving out of staging.
>
> > index 000000000000..aee5c7613b31
> > --- /dev/null
> > +++ b/drivers/staging/si4455/TODO
> > @@ -0,0 +1,3 @@
> > +TODO:
> > +        - add variable packet length support
> > +        - add firmware patching support in case of Si4455-C2A
>
> Why are these a requirement to get it out of staging?  Why go into =
staging at all?  Why not go into the 'real' part of the kernel directly?
> What is keeping that from happening today?
>
> These look like new features that you can add later, and shouldn't be =
a requirement for acceptance into the normal part of the kernel for this =
driver.  Why have you not tried doing that first?

Yes, you are right. The TODO list is for me, and the driver can get out =
of staging without these.
The curent state of the driver is completly covers my requirements, but =
I would complete these functions int he future.
The main reason for not implementing the firmware patching feature is, =
currently I have no Si4455-C2A in my development system.
My product is based on Si4455-B1A, but I'm waiting for the Si4455-C2A =
module.

> thanks,
>
> greg k-h


=C3=9Cdv=C3=B6zlettel / Best regards:
J=C3=B3zsef Horv=C3=A1th

