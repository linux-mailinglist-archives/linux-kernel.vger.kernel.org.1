Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45A1F0146
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgFEU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgFEU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:58:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B90C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:58:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so11574099ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPYZUsmfs5WnYVAoarP7tUTNo178WBFL9fmTCxqHlqA=;
        b=1m9tVrKgFOQH0n+QV774EN3QzFsS+biar5tfE+nouk9GHTa5PqALhFNT0qGElzorC+
         IQumukFgQtZGu7xGsJQo7qOOD9mD49PNvz+78x+R8B9no4uSwBZrOBaEGtGBbRlWlhB2
         GZvsOpnRvO0+TuWVLCSx7JlTgi1eD39IXbtbaXXD6BxXaFlu2lVNdh65N2nmCLDwK032
         gdfKONroT7kRHjRx4G3UyUMSg7Fd4uWXxIcKTmY94sKEmRomeEkr04fU9hzQjjo8kTP7
         wkHhzNAZF3gCWn6lSSzaUf5/3dpAIoctDtIu7QLRvmvLmAmAPf6vUyRCFu5/u5nVRTG+
         u8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPYZUsmfs5WnYVAoarP7tUTNo178WBFL9fmTCxqHlqA=;
        b=YgSk75L+jdFHVBUGC8J4gM7lfjyIoFFeFOztnPMS1iGWBOwRUDpcZ4UlqZ+TF10W8y
         dvMOv0sAb8roYZaGwPWuzygvtzdpFdyDdW35zor+so8jjWJvUEQ2proQWcpXH3uLRQIg
         wSGqjo+beBviqWdDPvwFWmT96YDhWpR+M4S94uv9QXzv4UvBPMrcueoJCNMVC1XMcFVv
         BqUFn/uHFJwTgCuxtiLBFmOzLa3XuLlxApI1F/bnhCcGZJUf+XCAAAg+SL7NxW7XYtvv
         FtNhCRbKbiYH3ioBz7YcqWZAT5wDAQWjOcPk3Cum2hEMoo2DAywv3DWojHvQUH/7U2hI
         PiVw==
X-Gm-Message-State: AOAM531SrgjkCAOuWBq3l4wfdP+z4EVNxwIFoYeH6foA9cuwmkvyPE+e
        sEViTtiX08tGpUovlYvPBsEkOSnlI+YUdbfGxs3nIQ==
X-Google-Smtp-Source: ABdhPJwQi1bsDHTaOnEfwgMwtaqFzHJKwF+WhBVZTA+yK7fOLfzcbO0JtooEAZV0rjgA7lOTEeI3ZzzsvUCAPu8qHTA=
X-Received: by 2002:a17:906:39a:: with SMTP id b26mr10957880eja.204.1591390703321;
 Fri, 05 Jun 2020 13:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200604234136.253703-1-vaibhav@linux.ibm.com>
 <20200604234136.253703-6-vaibhav@linux.ibm.com> <20200605194952.GS1505637@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200605194952.GS1505637@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jun 2020 13:58:11 -0700
Message-ID: <CAPcyv4h9+7FfnDxJk+zt2fDaMG9HR0XD=oSP0X6E8SPsNb3MSQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
 specific methods
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 12:50 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Jun 05, 2020 at 05:11:35AM +0530, Vaibhav Jain wrote:
> > Introduce support for PAPR NVDIMM Specific Methods (PDSM) in papr_scm
> > module and add the command family NVDIMM_FAMILY_PAPR to the white list
> > of NVDIMM command sets. Also advertise support for ND_CMD_CALL for the
> > nvdimm command mask and implement necessary scaffolding in the module
> > to handle ND_CMD_CALL ioctl and PDSM requests that we receive.
> >
> > The layout of the PDSM request as we expect from libnvdimm/libndctl is
> > described in newly introduced uapi header 'papr_pdsm.h' which
> > defines a new 'struct nd_pdsm_cmd_pkg' header. This header is used
> > to communicate the PDSM request via member
> > 'nd_cmd_pkg.nd_command' and size of payload that need to be
> > sent/received for servicing the PDSM.
> >
> > A new function is_cmd_valid() is implemented that reads the args to
> > papr_scm_ndctl() and performs sanity tests on them. A new function
> > papr_scm_service_pdsm() is introduced and is called from
> > papr_scm_ndctl() in case of a PDSM request is received via ND_CMD_CALL
> > command from libnvdimm.
> >
> > Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> > Changelog:
> >
> > v9..v10:
> > * Simplified 'struct nd_pdsm_cmd_pkg' by removing the
> >   'payload_version' field.
> > * Removed the corrosponding documentation on versioning and backward
> >   compatibility from 'papr_pdsm.h'
> > * Reduced the size of reserved fields to 4-bytes making 'struct
> >   nd_pdsm_cmd_pkg' 64 + 8 bytes long.
> > * Updated is_cmd_valid() to enforce validation checks on pdsm
> >   commands. [ Dan Williams ]
> > * Added check for reserved fields being set to '0' in is_cmd_valid()
> >   [ Ira ]
> > * Moved changes for checking cmd_rc == NULL and logging improvements
> >   to a separate prelim patch [ Ira ].
> > * Moved  pdsm package validation checks from papr_scm_service_pdsm()
> >   to is_cmd_valid().
> > * Marked papr_scm_service_pdsm() return type as 'void' since errors
> >   are reported in nd_pdsm_cmd_pkg.cmd_status field.
> >
> > Resend:
> > * Added ack from Aneesh.
> >
> > v8..v9:
> > * Reduced the usage of term SCM replacing it with appropriate
> >   replacement [ Dan Williams, Aneesh ]
> > * Renamed 'papr_scm_pdsm.h' to 'papr_pdsm.h'
> > * s/PAPR_SCM_PDSM_*/PAPR_PDSM_*/g
> > * s/NVDIMM_FAMILY_PAPR_SCM/NVDIMM_FAMILY_PAPR/g
> > * Minor updates to 'papr_psdm.h' to replace usage of term 'SCM'.
> > * Minor update to patch description.
> >
> > v7..v8:
> > * Removed the 'payload_offset' field from 'struct
> >   nd_pdsm_cmd_pkg'. Instead command payload is always assumed to start
> >   at 'nd_pdsm_cmd_pkg.payload'. [ Aneesh ]
> > * To enable introducing new fields to 'struct nd_pdsm_cmd_pkg',
> >   'reserved' field of 10-bytes is introduced. [ Aneesh ]
> > * Fixed a typo in "Backward Compatibility" section of papr_scm_pdsm.h
> >   [ Ira ]
> >
> > Resend:
> > * None
> >
> > v6..v7 :
> > * Removed the re-definitions of __packed macro from papr_scm_pdsm.h
> >   [Mpe].
> > * Removed the usage of __KERNEL__ macros in papr_scm_pdsm.h [Mpe].
> > * Removed macros that were unused in papr_scm.c from papr_scm_pdsm.h
> >   [Mpe].
> > * Made functions defined in papr_scm_pdsm.h as static inline. [Mpe]
> >
> > v5..v6 :
> > * Changed the usage of the term DSM to PDSM to distinguish it from the
> >   ACPI term [ Dan Williams ]
> > * Renamed papr_scm_dsm.h to papr_scm_pdsm.h and updated various struct
> >   to reflect the new terminology.
> > * Updated the patch description and title to reflect the new terminology.
> > * Squashed patch to introduce new command family in 'ndctl.h' with
> >   this patch [ Dan Williams ]
> > * Updated the papr_scm_pdsm method starting index from 0x10000 to 0x0
> >   [ Dan Williams ]
> > * Removed redundant license text from the papr_scm_psdm.h file.
> >   [ Dan Williams ]
> > * s/envelop/envelope/ at various places [ Dan Williams ]
> > * Added '__packed' attribute to command package header to gaurd
> >   against different compiler adding paddings between the fields.
> >   [ Dan Williams]
> > * Converted various pr_debug to dev_debug [ Dan Williams ]
> >
> > v4..v5 :
> > * None
> >
> > v3..v4 :
> > * None
> >
> > v2..v3 :
> > * Updated the patch prefix to 'ndctl/uapi' [Aneesh]
> >
> > v1..v2 :
> > * None
> > ---
> >  arch/powerpc/include/uapi/asm/papr_pdsm.h |  98 +++++++++++++++++++
> >  arch/powerpc/platforms/pseries/papr_scm.c | 113 +++++++++++++++++++++-
> >  include/uapi/linux/ndctl.h                |   1 +
> >  3 files changed, 207 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/powerpc/include/uapi/asm/papr_pdsm.h
> >
> > diff --git a/arch/powerpc/include/uapi/asm/papr_pdsm.h b/arch/powerpc/include/uapi/asm/papr_pdsm.h
> > new file mode 100644
> > index 000000000000..8b1a4f8fa316
> > --- /dev/null
> > +++ b/arch/powerpc/include/uapi/asm/papr_pdsm.h
> > @@ -0,0 +1,98 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * PAPR nvDimm Specific Methods (PDSM) and structs for libndctl
> > + *
> > + * (C) Copyright IBM 2020
> > + *
> > + * Author: Vaibhav Jain <vaibhav at linux.ibm.com>
> > + */
> > +
> > +#ifndef _UAPI_ASM_POWERPC_PAPR_PDSM_H_
> > +#define _UAPI_ASM_POWERPC_PAPR_PDSM_H_
> > +
> > +#include <linux/types.h>
> > +
> > +/*
> > + * PDSM Envelope:
> > + *
> > + * The ioctl ND_CMD_CALL transfers data between user-space and kernel via
> > + * envelope which consists of a header and user-defined payload sections.
> > + * The header is described by 'struct nd_pdsm_cmd_pkg' which expects a
> > + * payload following it and accessible via 'nd_pdsm_cmd_pkg.payload' field.
> > + * There is reserved field that can used to introduce new fields to the
> > + * structure in future. It also tries to ensure that 'nd_pdsm_cmd_pkg.payload'
> > + * lies at a 8-byte boundary.
> > + *
> > + *  +-------------+---------------------+---------------------------+
> > + *  |   64-Bytes  |       8-Bytes       |       Max 184-Bytes       |
> > + *  +-------------+---------------------+---------------------------+
> > + *  |               nd_pdsm_cmd_pkg     |                           |
> > + *  |-------------+                     |                           |
> > + *  |  nd_cmd_pkg |                     |                           |
> > + *  +-------------+---------------------+---------------------------+
> > + *  | nd_family   |                     |                           |
> > + *  | nd_size_out | cmd_status          |                           |
> > + *  | nd_size_in  | reserved            |     payload               |
> > + *  | nd_command  |                     |                           |
> > + *  | nd_fw_size  |                     |                           |
> > + *  +-------------+---------------------+---------------------------+
> > + *
> > + * PDSM Header:
> > + *
> > + * The header is defined as 'struct nd_pdsm_cmd_pkg' which embeds a
> > + * 'struct nd_cmd_pkg' instance. The PDSM command is assigned to member
> > + * 'nd_cmd_pkg.nd_command'. Apart from size information of the envelope which is
> > + * contained in 'struct nd_cmd_pkg', the header also has members following
> > + * members:
> > + *
> > + * 'cmd_status'              : (Out) Errors if any encountered while servicing PDSM.
> > + * 'reserved'                : Not used, reserved for future and should be set to 0.
> > + *
> > + * PDSM Payload:
> > + *
> > + * The layout of the PDSM Payload is defined by various structs shared between
> > + * papr_scm and libndctl so that contents of payload can be interpreted. During
> > + * servicing of a PDSM the papr_scm module will read input args from the payload
> > + * field by casting its contents to an appropriate struct pointer based on the
> > + * PDSM command. Similarly the output of servicing the PDSM command will be
> > + * copied to the payload field using the same struct.
> > + *
> > + * 'libnvdimm' enforces a hard limit of 256 bytes on the envelope size, which
> > + * leaves around 184 bytes for the envelope payload (ignoring any padding that
> > + * the compiler may silently introduce).
> > + *
> > + */
> > +
> > +/* PDSM-header + payload expected with ND_CMD_CALL ioctl from libnvdimm */
> > +struct nd_pdsm_cmd_pkg {
> > +     struct nd_cmd_pkg hdr;  /* Package header containing sub-cmd */
> > +     __s32 cmd_status;       /* Out: Sub-cmd status returned back */
> > +     __u16 reserved[2];      /* Ignored and to be used in future */
> > +     __u8 payload[];         /* In/Out: Sub-cmd data buffer */
> > +} __packed;
> > +
> > +/*
> > + * Methods to be embedded in ND_CMD_CALL request. These are sent to the kernel
> > + * via 'nd_pdsm_cmd_pkg.hdr.nd_command' member of the ioctl struct
> > + */
> > +enum papr_pdsm {
> > +     PAPR_PDSM_MIN = 0x0,
> > +     PAPR_PDSM_MAX,
> > +};
> > +
> > +/* Convert a libnvdimm nd_cmd_pkg to pdsm specific pkg */
> > +static inline struct nd_pdsm_cmd_pkg *nd_to_pdsm_cmd_pkg(struct nd_cmd_pkg *cmd)
> > +{
> > +     return (struct nd_pdsm_cmd_pkg *)cmd;
> > +}
> > +
> > +/* Return the payload pointer for a given pcmd */
> > +static inline void *pdsm_cmd_to_payload(struct nd_pdsm_cmd_pkg *pcmd)
> > +{
> > +     if (pcmd->hdr.nd_size_in == 0 && pcmd->hdr.nd_size_out == 0)
> > +             return NULL;
> > +     else
> > +             return (void *)(pcmd->payload);
> > +}
>
> I just realized these were in the uapi header.  You don't want to do this as
> this code gets built into any user space program that uses it and there may be
> license issues if the user space code is not a compatible license.

Yes, include/uapi/linux/ndctl.h is specifically LGPL for this reason.
