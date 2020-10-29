Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD729F77C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJ2WMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2WMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:12:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF9FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:11:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r3so1985728plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MvPDhdjyj/x0sOXIvdPEH0n3TSY+pHI4jeWBqxXcZzE=;
        b=MuONn1wr3kaGJN/Ss95U6DztgcRN47yRwujxzR0jjYPqP+M66XVZgRrQcMNyNasWLe
         OvHVWG8ZZe+2qx2/cMnAl47uHydrQc1IVMZ0IN92vG42k4yc5GArqoQkT4pkFwTgj34C
         lNyjvrE/Rx6mQ/gDYIvmgnNXk9hC6yq+RV9/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MvPDhdjyj/x0sOXIvdPEH0n3TSY+pHI4jeWBqxXcZzE=;
        b=cJDlNpgAq2w83VOpzhILTLAfis+m1sfmRGYiSc+laJATvzZ/em6beltlCFNZP7/yF1
         62Qx7q2vwbaIIM0Zc+WNFm2G5KQB4gW0Mar7Onsl7kClwwwAgrMqAMOAnowpul6HF7Qk
         Xdvqibal+bmIpN5MUwhbu5ankRH14wRJzxUc/xDuSQLHbxoKt1dm7gdhAvojb0Pzfgn0
         VlrzCqS0/PIvKBYRonMATmuNKz0tcWjEtkG7hgqQxlQHY0pg/xwS89ahbzm60wPy63cg
         O5QYX/mZluVpDp2G6R+SjV4suk+7I5iDuaOV+XakfOB8MXrSMKOd3Jq0ZJk04/WCFfDB
         11Yg==
X-Gm-Message-State: AOAM532UXg/ZD2bfpVC7Wb0S5UoHaj6Mj6ECEc/r8GAqaMDqadu8NT7f
        F/kFXGzMG8wiIf/uYxJBc6UG8MBN+VioMw==
X-Google-Smtp-Source: ABdhPJxmAaOqHCs3NjBmKvTRKFdRuH3GRJfBqJleErDn0J4XYBD5ky3dd5B8xUuWkYGPCX0NiqILKQ==
X-Received: by 2002:a17:902:ee0b:b029:d3:c8dc:6db8 with SMTP id z11-20020a170902ee0bb02900d3c8dc6db8mr6403488plb.55.1604009516632;
        Thu, 29 Oct 2020 15:11:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q123sm3950366pfq.56.2020.10.29.15.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:11:55 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:11:54 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 7/7] platform/chrome: cros_ec_typec: Register partner
 altmodes
Message-ID: <20201029221154.GB3913249@google.com>
References: <20201021205317.708008-1-pmalani@chromium.org>
 <20201021205317.708008-8-pmalani@chromium.org>
 <20201028131732.GB2026875@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028131732.GB2026875@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thank you for reviewing the patch!

On Wed, Oct 28, 2020 at 03:17:32PM +0200, Heikki Krogerus wrote:
> Hi,
> 
> On Wed, Oct 21, 2020 at 01:53:16PM -0700, Prashant Malani wrote:
> > +static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num)
> > +{
> > +	struct cros_typec_port *port = typec->ports[port_num];
> > +	struct cros_typec_altmode_node *node;
> > +
> > +	while (!list_empty(&port->partner_mode_list)) {
> > +		node = list_first_entry(&port->partner_mode_list, struct cros_typec_altmode_node,
> > +					list);
> 
>         ...
>         struct cros_typec_altmode_node *node, *tmp;
> 
>         list_for_each_entry_safe(node, tmp, &port->partner_mode_list, list) {
> 

Nice; I will make this update in v2. Thanks!

Best regards,

-Prashant
