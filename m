Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99CC1F130F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgFHGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 02:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgFHGtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:49:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EFBC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 23:49:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so9373413ljv.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HY1q3zEFEuZdSHcONcA0HTu7dGzl2GVShhXVS/+Py/E=;
        b=nkouC83FhdvfUge1uPcUCigQJnbNcPlx2j8amGwK6223AJWazoMjsBoaabHJQfgANL
         BnVMkKgWxeqloFUBjPazilWWRJmw7vAtmCcYXu6LAL/mqQXcAywUL7OZSZsehREzN/KR
         Rs9vpjXAsQnrisggRBFjCx9q5Ehl7+VodsZo0AYwsYDQp/ZBdjMBOKHI71FtT2Z7djTy
         0lascHS57aR7k/SgPQ0vQKOynTKLmF+D+/9K7gNNnzzXoBLM9MHdpsW94yQYvspkg08x
         uZjAblfRSTnC69lOGaHCgurBA1lHUqJTXxM63+b5jYDWmrJOxmF5/1ThuLGm8DsX6CE3
         gEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HY1q3zEFEuZdSHcONcA0HTu7dGzl2GVShhXVS/+Py/E=;
        b=sEqcCcIcaNnNDaE9xJdvrcTFpHcTdpAPGzBXXT3yXLHNEdTshI34DL+W7xBSv6/Tzx
         YQ6FwYXQWgBD4Mm/konvgzbH2gs1Q/lAHX0fd7rIkh4c1rj+usz1D6nvpBmZewa0rCZZ
         /Emk4YrSj/OzY/bkuBl6s8iIrH0ue6P2SYlM0pjfMq+dY78lKkjS66nw3gG8bVDvxm3s
         8a1LG0eT599fINsScnDruDC4DpQZx14Lev0KbReDzCuN0+J5pLQ1vNYBPE2VpWBu1FtN
         IanekHTX438vDoZIlLeHqMHQSDVdoQnlpFOySDb84VAXOThGpVN0qDsbECpjqxliIobi
         tbNA==
X-Gm-Message-State: AOAM532cOyZntF9oTFmVas0paLlVgrxBMqPwJkg3QqUfy7QGmVyUfGHf
        I3EAWt8Xphd00fCMFRwK2Wniow==
X-Google-Smtp-Source: ABdhPJz/uaagw0s6yDeWVe2FkADWUsSZxcYiPkcdKQTG9cT2BC0WMk1qvsVReJzfCUcW7mvGRnq/7w==
X-Received: by 2002:a2e:9081:: with SMTP id l1mr11092490ljg.81.1591598947463;
        Sun, 07 Jun 2020 23:49:07 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id k29sm3524384ljc.136.2020.06.07.23.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 23:49:06 -0700 (PDT)
Date:   Mon, 8 Jun 2020 08:49:04 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        ricardo@foundries.io, mike@foundries.io,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Tee-dev] [PATCH v2] drivers: optee: allow op-tee to access
 devices on the i2c bus
Message-ID: <20200608064904.GA1187395@jade>
References: <20200531231135.12670-1-jorge@foundries.io>
 <CAFA6WYNKSgkGzuz47MBzdYzKd3__zPP2HNaOv7P-KR8RFea9fg@mail.gmail.com>
 <20200601072446.GA28120@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200601072446.GA28120@trex>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 09:24:46AM +0200, Jorge Ramirez-Ortiz, Foundries wrote:
> On 01/06/20, Sumit Garg wrote:
> > Hi Jorge,
> 
> hey
> 
> > 
> > On Mon, 1 Jun 2020 at 04:41, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> > >
> > > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > > control this type of cryptographic devices it needs coordinated access
> > > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > >
> > > This trampoline driver allow OP-TEE to access them.
> > >
> > 
> > This sounds like an interesting use-case but I would like to
> > understand how secure is this communication interface with the secure
> > element? Like in the case of RPMB, secure world data is encrypted
> > which flows via tee-supplicant to RPMB device.
> 
> right, the data in the buffer should be encrypted in both directions
> (in the case of the SE050 [1] we have the option to operate with or
> without encryption which is what I am doing during development
> [2]).
> 
> But ultimately -before any product can be shipped- all comms must be
> encrypted: this means that when OP-TEE uses the SE050 for crypto, it
> must encrypt the data on write and decrypt what is comming from the
> SE050 on read. I am now looking into how to enable this.
> 
> [1] https://www.nxp.com/docs/en/data-sheet/SE050-DATASHEET.pdf
> [2] https://github.com/ldts/optee_os/commits/se050
This link doesn't work.

> 
> > 
> > -Sumit
> > 
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > ---
> > >  drivers/tee/optee/optee_msg.h | 18 +++++++++++
> > >  drivers/tee/optee/rpc.c       | 57 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 75 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > > index 795bc19ae17a..b6cc964fdeea 100644
> > > --- a/drivers/tee/optee/optee_msg.h
> > > +++ b/drivers/tee/optee/optee_msg.h
> > > @@ -419,4 +419,22 @@ struct optee_msg_arg {
> > >   */
> > >  #define OPTEE_MSG_RPC_CMD_SHM_FREE     7
> > >
> > > +/*
> > > + * Access a device on an i2c bus
> > > + *
> > > + * [in]  param[0].u.value.a            mode: RD(0), WR(1)
> > > + * [in]  param[0].u.value.b            i2c adapter
> > > + * [in]  param[0].u.value.c            i2c chip
> > > + *
> > > + * [io]  param[1].u.tmem.buf_ptr       physical address
> > > + * [io]  param[1].u.tmem.size          transfer size in bytes
> > > + * [io]  param[1].u.tmem.shm_ref       shared memory reference

This should be "[in/out] memref[1]" instead to be able to use
all kinds of memory references.

> > > + *
> > > + * [out]  param[0].u.value.a           bytes transferred
> > > + *
> > > + */
> > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 8
> > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> > > +
> > >  #endif /* _OPTEE_MSG_H */
> > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > index b4ade54d1f28..21d452805c6f 100644
> > > --- a/drivers/tee/optee/rpc.c
> > > +++ b/drivers/tee/optee/rpc.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/device.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/tee_drv.h>
> > > +#include <linux/i2c.h>
> > >  #include "optee_private.h"
> > >  #include "optee_smc.h"
> > >
> > > @@ -48,6 +49,59 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> > >  bad:
> > >         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > >  }
> > > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > +                                            struct optee_msg_arg *arg)
> > > +{
> > > +       struct i2c_client client;
> > > +       struct tee_shm *shm;
> > > +       int i, ret;
> > > +       char *buf;
> > > +       uint32_t attr[] = {
> > > +               OPTEE_MSG_ATTR_TYPE_VALUE_INPUT,
> > > +               OPTEE_MSG_ATTR_TYPE_TMEM_INOUT,
> > > +               OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT,
> > > +       };
> > > +
> > > +       if (arg->num_params != ARRAY_SIZE(attr))
> > > +               goto bad;

Use optee_from_msg_param() to translate this into a struct tee_param,
that way you cover all kinds of memory references. Before returning it
nees to be translated back with optee_to_msg_param().

Cheers,
Jens

> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(attr); i++)
> > > +               if ((arg->params[i].attr & OPTEE_MSG_ATTR_TYPE_MASK) != attr[i])
> > > +                       goto bad;
> > > +
> > > +       shm = (struct tee_shm *)(unsigned long)arg->params[1].u.tmem.shm_ref;
> > > +       buf = (char *)shm->kaddr;
> > > +
> > > +       client.addr = arg->params[0].u.value.c;
> > > +       client.adapter = i2c_get_adapter(arg->params[0].u.value.b);
> > > +       if (!client.adapter)
> > > +               goto bad;
> > > +
> > > +       snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > > +
> > > +       switch (arg->params[0].u.value.a) {
> > > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > > +               ret = i2c_master_recv(&client, buf, arg->params[1].u.tmem.size);
> > > +               break;
> > > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > > +               ret = i2c_master_send(&client, buf, arg->params[1].u.tmem.size);
> > > +               break;
> > > +       default:
> > > +               i2c_put_adapter(client.adapter);
> > > +               goto bad;
> > > +       }
> > > +
> > > +       if (ret >= 0) {
> > > +               arg->params[2].u.value.a = ret;
> > > +               arg->ret = TEEC_SUCCESS;
> > > +       } else
> > > +               arg->ret = TEEC_ERROR_COMMUNICATION;
> > > +
> > > +       i2c_put_adapter(client.adapter);
> > > +       return;
> > > +bad:
> > > +       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > > +}
> > >
> > >  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
> > >  {
> > > @@ -382,6 +436,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> > >         case OPTEE_MSG_RPC_CMD_SHM_FREE:
> > >                 handle_rpc_func_cmd_shm_free(ctx, arg);
> > >                 break;
> > > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> > > +               handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> > > +               break;
> > >         default:
> > >                 handle_rpc_supp_cmd(ctx, arg);
> > >         }
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > Tee-dev mailing list
> > > Tee-dev@lists.linaro.org
> > > https://lists.linaro.org/mailman/listinfo/tee-dev
