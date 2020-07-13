Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848B21A7D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 21:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGITbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGITbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:31:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B79C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 12:30:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so3187330wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L+LwzgLNEgol7CXfPapnfKmz3dkEdqHIky+sLEe7mDM=;
        b=sjI6DwpFKsR6gK/VMhtAGOCdKTzdrmwVAONuYp4qgTpkS93cRn3Y7CxugSZ96WKmCk
         Do6BGNye0fYKu163ytYi3CmCrlrvogHvHiVRjPVQK3mXHkxV6xjheqJoAh5T45DHLSn4
         jmcfvD2epFdPOYhj6dYwqF9hG1lL/zKXS7g7VtWnX1O2cNsbOus0swj//UwryID4sHEz
         pT6j6wULZXCpjfW18nr8vyKj6TbvzE26gaILJYyOQ+/XsC+lmcXpfWKaICSb4FOoAAt9
         RyvcUwC7exvH/uGGx1bb7HSYKo+4g1MlJdwrmUFC0fPaBEQlWlHU/AuVIHMMMeswlq2h
         6gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L+LwzgLNEgol7CXfPapnfKmz3dkEdqHIky+sLEe7mDM=;
        b=FTRdFRqWeNTSpxU8QGxxtt8Xt50xNfnH258kihzrvs8aQ81KrOU9dbuM/dS54q1n6r
         /wCW9EVSdcdqP6EwugViyXahI7e18JdhOLdjFgUCm0TXbfLV5eyBYfyGnlVQM1zUMdHw
         ruOG3LLfEOLtPVGsWPssgSkLDmTKKszv1Lh1IncwTk59n/pY4pH/h623UCxoRiO0mulv
         CjQ2Mf5bcQUA9V3hkrG6HFziZQ1ntGRCS9rzxDM6dMBHHSrcTIVjYiCxsFebRjKG8Qdd
         S5ZBrP5Cog08PmNLhFj68KEB7TnjfNk6jPyS2Ri/FzaICRl3ap3U8Y6xueVWdEIOlqsy
         z5/A==
X-Gm-Message-State: AOAM531tlactJnh0JFxXrKJPpYAHl5zcduCQ2n4GTRwHq/ve7TTiXkvq
        +HaQJct/CamNHCPpChPrHkbHTjC6YNc=
X-Google-Smtp-Source: ABdhPJwGEKhh/PCpKUnxXNb35yPFp0vg18Wi1RCEtzRH5rArf/zDzv+9pwDPdE7RWQ4lF0uKeKBwyA==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr1479379wmf.146.1594323058275;
        Thu, 09 Jul 2020 12:30:58 -0700 (PDT)
Received: from dell ([109.180.115.154])
        by smtp.gmail.com with ESMTPSA id n16sm5919830wmc.40.2020.07.09.12.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 12:30:57 -0700 (PDT)
Date:   Thu, 9 Jul 2020 20:30:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 24/24] scsi: aic7xxx: aic79xx_osm: Remove set but unused
 variabes 'saved_scsiid' and 'saved_modes'
Message-ID: <20200709193055.GA3500@dell>
References: <20200709174556.7651-1-lee.jones@linaro.org>
 <20200709174556.7651-25-lee.jones@linaro.org>
 <1594318443.10411.14.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594318443.10411.14.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jul 2020, James Bottomley wrote:

> On Thu, 2020-07-09 at 18:45 +0100, Lee Jones wrote:
> > Haven't been used since 2006.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/scsi/aic7xxx/aic79xx_osm.c: In function
> > ‘ahd_linux_queue_abort_cmd’:
> >  drivers/scsi/aic7xxx/aic79xx_osm.c:2155:17: warning: variable
> > ‘saved_modes’ set but not used [-Wunused-but-set-variable]
> >  drivers/scsi/aic7xxx/aic79xx_osm.c:2148:9: warning: variable
> > ‘saved_scsiid’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Hannes Reinecke <hare@suse.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/scsi/aic7xxx/aic79xx_osm.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c
> > b/drivers/scsi/aic7xxx/aic79xx_osm.c
> > index 3782a20d58885..b0c6701f64a83 100644
> > --- a/drivers/scsi/aic7xxx/aic79xx_osm.c
> > +++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
> > @@ -2141,14 +2141,12 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > *cmd)
> >  	u_int  saved_scbptr;
> >  	u_int  active_scbptr;
> >  	u_int  last_phase;
> > -	u_int  saved_scsiid;
> >  	u_int  cdb_byte;
> >  	int    retval;
> >  	int    was_paused;
> >  	int    paused;
> >  	int    wait;
> >  	int    disconnected;
> > -	ahd_mode_state saved_modes;
> >  	unsigned long flags;
> >  
> >  	pending_scb = NULL;
> > @@ -2239,7 +2237,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > *cmd)
> >  		goto done;
> >  	}
> >  
> > -	saved_modes = ahd_save_modes(ahd);
> > +	ahd_save_modes(ahd);
> 
> Well, this is clearly wrong, since ahd_save_modes has no side effects.

Great.  Thanks for letting me know.

I tend to err on the side of caution with these types of fix-ups.

I will remove it.

> However, I think it also means there's a bug in this code:
> 
> >  	ahd_set_modes(ahd, AHD_MODE_SCSI, AHD_MODE_SCSI);
> 
> You can't do this without later restoring the mode, so someone needs to
> figure out where the missing ahd_restore_modes() should go.
> 
> >  	last_phase = ahd_inb(ahd, LASTPHASE);
> >  	saved_scbptr = ahd_get_scbptr(ahd);
> > @@ -2257,7 +2255,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > *cmd)
> >  	 * passed in command.  That command is currently active on
> > the
> >  	 * bus or is in the disconnected state.
> >  	 */
> > -	saved_scsiid = ahd_inb(ahd, SAVED_SCSIID);
> > +	ahd_inb(ahd, SAVED_SCSIID);
> 
> I think this can just go.

Happy to remove it also.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
