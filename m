Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D662F269F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhALDVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:21:15 -0500
Received: from mail.v3.sk ([167.172.186.51]:35964 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbhALDVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:21:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A7BBADF242;
        Tue, 12 Jan 2021 03:16:46 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DIWAVnSiqYGb; Tue, 12 Jan 2021 03:16:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BC4C0DF890;
        Tue, 12 Jan 2021 03:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gWyR4YWaQsRt; Tue, 12 Jan 2021 03:16:44 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 930C7DF242;
        Tue, 12 Jan 2021 03:16:43 +0000 (UTC)
Date:   Tue, 12 Jan 2021 04:20:28 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: ariel-pwrbutton.c: Remove unused variable
 ariel_pwrbutton_id_table[]
Message-ID: <20210112032028.GB1503339@demiurge.local>
References: <1608581041-4354-1-git-send-email-jrdr.linux@gmail.com>
 <CAFqt6zb2O3SFx6xDtwdSgHYH-zeGXwuf1=Hr5yYXnCDqAza9KQ@mail.gmail.com>
 <X/OQZcsD15Fl/XVw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/OQZcsD15Fl/XVw@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:02:13PM -0800, Dmitry Torokhov wrote:
> On Tue, Dec 29, 2020 at 01:15:10PM +0530, Souptick Joarder wrote:
> > On Tue, Dec 22, 2020 at 1:34 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > Kernel test robot throws below warning ->
> > >
> > > >> drivers/input/misc/ariel-pwrbutton.c:152:35: warning: unused variable
> > > >> 'ariel_pwrbutton_id_table' [-Wunused-const-variable]
> > >    static const struct spi_device_id ariel_pwrbutton_id_table[] = {
> > >                                      ^
> > >    1 warning generated.
> > >
> > > Remove unused variable ariel_pwrbutton_id_table[] if no plan to use
> > > it further.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > 
> > Any comment on this patch ?
> 
> Lubomir, would you prefer to remove the table or add it to the driver
> structure as ariel_pwrbutton_driver->id_table?

I believe it can be safely dropped, as the OF match seems to be
sufficient.

Thank you for the patch Souptick.

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

> 
> Thanks.
> 
> -- 
> Dmitry
