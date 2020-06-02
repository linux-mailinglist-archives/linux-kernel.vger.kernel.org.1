Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F400E1EC5C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 01:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgFBXdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 19:33:10 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57792 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgFBXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:33:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E7F788030835;
        Tue,  2 Jun 2020 23:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A6Eb2LHBhb4B; Wed,  3 Jun 2020 02:33:06 +0300 (MSK)
Date:   Wed, 3 Jun 2020 02:33:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        kbuild test robot <lkp@intel.com>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: bt1-pvt: Declare Temp- and Volt-to-N poly when
 alarms are enabled
Message-ID: <20200602233305.bprka2qx6e2tpfz5@mobilestation>
References: <20200602091219.24404-1-Sergey.Semin@baikalelectronics.ru>
 <20200602140746.GA82514@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200602140746.GA82514@roeck-us.net>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 07:07:46AM -0700, Guenter Roeck wrote:
> On Tue, Jun 02, 2020 at 12:12:19PM +0300, Serge Semin wrote:
> > Clang-based kernel building with W=1 warns that some static const
> > variables are unused:
> > 
> > drivers/hwmon/bt1-pvt.c:67:30: warning: unused variable 'poly_temp_to_N' [-Wunused-const-variable]
> > static const struct pvt_poly poly_temp_to_N = {
> >                              ^
> > drivers/hwmon/bt1-pvt.c:99:30: warning: unused variable 'poly_volt_to_N' [-Wunused-const-variable]
> > static const struct pvt_poly poly_volt_to_N = {
> >                              ^
> > 
> > Indeed these polynomials are utilized only when the PVT sensor alarms are
> > enabled. In that case they are used to convert the temperature and
> > voltage alarm limits from normal quantities (Volts and degree Celsius) to
> > the sensor data representation N = [0, 1023]. Otherwise when alarms are
> > disabled the driver only does the detected data conversion to the human
> > readable form and doesn't need that polynomials defined. So let's declare
> > the Temp-to-N and Volt-to-N polynomials only if the PVT alarms are
> > switched on at compile-time.
> > 
> > Note gcc with W=1 doesn't notice the problem.
> > 
> > Fixes: 87976ce2825d ("hwmon: Add Baikal-T1 PVT sensor driver")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> 

> I don't really like the added #if. Can you use __maybe_unused instead ?

Ok. __maybe_unused is much better. Thanks for suggestion.

-Sergey

> 
> Thanks,
> Guenter
> 
> > ---
> >  drivers/hwmon/bt1-pvt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
> > index 1a9772fb1f73..1a5212c04549 100644
> > --- a/drivers/hwmon/bt1-pvt.c
> > +++ b/drivers/hwmon/bt1-pvt.c
> > @@ -64,6 +64,7 @@ static const struct pvt_sensor_info pvt_info[] = {
> >   *     48380,
> >   * where T = [-48380, 147438] mC and N = [0, 1023].
> >   */
> > +#if defined(CONFIG_SENSORS_BT1_PVT_ALARMS)
> >  static const struct pvt_poly poly_temp_to_N = {
> >  	.total_divider = 10000,
> >  	.terms = {
> > @@ -74,6 +75,7 @@ static const struct pvt_poly poly_temp_to_N = {
> >  		{0, 1720400, 1, 1}
> >  	}
> >  };
> > +#endif /* CONFIG_SENSORS_BT1_PVT_ALARMS */
> >  
> >  static const struct pvt_poly poly_N_to_temp = {
> >  	.total_divider = 1,
> > @@ -96,6 +98,7 @@ static const struct pvt_poly poly_N_to_temp = {
> >   * N = (18658e-3*V - 11572) / 10,
> >   * V = N * 10^5 / 18658 + 11572 * 10^4 / 18658.
> >   */
> > +#if defined(CONFIG_SENSORS_BT1_PVT_ALARMS)
> >  static const struct pvt_poly poly_volt_to_N = {
> >  	.total_divider = 10,
> >  	.terms = {
> > @@ -103,6 +106,7 @@ static const struct pvt_poly poly_volt_to_N = {
> >  		{0, -11572, 1, 1}
> >  	}
> >  };
> > +#endif /* CONFIG_SENSORS_BT1_PVT_ALARMS */
> >  
> >  static const struct pvt_poly poly_N_to_volt = {
> >  	.total_divider = 10,
