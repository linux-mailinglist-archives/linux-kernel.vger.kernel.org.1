Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BBA2FF228
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbhAURkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbhAURDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:03:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556B0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:03:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n6so3313364edt.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+TZZsn+eqR6dTUulMdxx7PCbvr89MO/4XGUQAazVhU=;
        b=qgklzAjQOOZAhjLACjNI3HGCva6Z/AY6d3/GYc5AKCflwmduNLQhSv2QoGHQJoNgnl
         K8u6tzI7b8rumOkz5fPTSocWVkUsUBnPZi7aW1L4sfXlZhGcpch5Fwo3UknfdKxtMJkR
         M+06MHL7ItA+S4Y+iigUH4JZ8V7YR0J0Po0vEsBFysyNKISgY+HGX+9ciC1mt6Z7iUNs
         mSLj+D0iDiPcPl633WbP75IdxPQD7UDulesSYJ05L3JXRotfL3y732JvVIYenpGnH7jB
         BhhQzOoONYtyA4jXFAzkchZFRdO4Mp89gj/5nQAWYZGybz1Wju3o43o/gdCNhSToy2NO
         2AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+TZZsn+eqR6dTUulMdxx7PCbvr89MO/4XGUQAazVhU=;
        b=AD1gsSEQFtiw5HHZ31YAvEAM663Tv8HEk6SckTjR+kcPVJVvNbWvIQWYq1jtgUkNjY
         R5faF8bG2h8s4HVmSjWN4QQI3daE3CxJsPcOnoGmGsh0HBJMj5KIzsh+DtL2HdZQxDWJ
         dNSqAOnTPQXqjlVy7h+4iCuirubkJ9vjL/+z4xdfaXjhieOFm161WAKpL+eoPKEF/F9E
         fGZkUqKfm397bGtjUCUcwm5jMg2zcVIdjYtnrDEGZ+qpSd2FN07E/n8yb+wN/+1ka04i
         mCzTgeqLg5ZMRtoRBcaUMkBmUVrzrh3NNC/Iq39V5hzaCrBupxpGmAJ8zSO5+yHJpror
         rhVw==
X-Gm-Message-State: AOAM5333Ym+MsEy/QGur2O90j/ohbeNFcVJa8x+RDUf37maH6WWMXu+r
        S2hq5NDgu5iaS9JYcE91GyGkVHP4tU/VDRgi1FhbwguhYNE=
X-Google-Smtp-Source: ABdhPJzJLLvdtRLueXSdnMYSOmghDAPfUSB4ghbCw5HZxdtuI7Z5ogkE5CUxZQGuTLW2XdyrO5QxRQGuAFGehCsiW/k=
X-Received: by 2002:aa7:d610:: with SMTP id c16mr72438edr.354.1611248579079;
 Thu, 21 Jan 2021 09:02:59 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117154856.2853729.1012816981381380656.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YAk4MMMmmbKe6XEQ@kroah.com>
In-Reply-To: <YAk4MMMmmbKe6XEQ@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Jan 2021 09:02:53 -0800
Message-ID: <CAPcyv4h74NjqcuUjv4zFKHAxio_bV0bngLoxP=ACw=JvMfq-UA@mail.gmail.com>
Subject: Re: [PATCH 3/3] libnvdimm/ioctl: Switch to cdev_register_queued()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 20, 2021 at 11:39:08AM -0800, Dan Williams wrote:
> > The ioctl implementation in libnvdimm is a case study in what can be
> > cleaned up when the cdev core handles synchronizing in-flight ioctls
> > with device removal. Switch to cdev_register_queued() which allows for
> > the ugly context lookup and activity tracking implementation to be
> > dropped, among other cleanups.
>
> I'm confused, the cdev handles the filesystem access from /dev/ which
> handles the ioctl.  Any use of a cdev with relationship to a struct
> device that might go away is independent, so we really should not tie
> these together in any way.

Oh, no, there's no object lifetime ties here, that problem was already
solved with Logan's addition of cdev_device_add(). Instead, this about
file_operations liveness. Look at procfs and debugfs that Christoph
pointed out have open coded the same facility. When the driver is
unbound ongoing file operations should be flushed and blocked
currently the cdev api is forcing every driver to open code this
themselves.

This seems a pattern that is asking to be unified as a general
"managed fops" concept.
