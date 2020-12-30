Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A724B2E79FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgL3OiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgL3OiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:38:10 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8520821919;
        Wed, 30 Dec 2020 14:37:22 +0000 (UTC)
Date:   Wed, 30 Dec 2020 14:37:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 1/5] counter: Internalize sysfs interface code
Message-ID: <20201230143719.28a90914@archlinux>
In-Reply-To: <fc40ab7f4a38e80d86715daa5eaf744dd645a75b.1608935587.git.vilhelm.gray@gmail.com>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
        <fc40ab7f4a38e80d86715daa5eaf744dd645a75b.1608935587.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Dec 2020 19:15:34 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This is a reimplementation of the Generic Counter driver interface.
> There are no modifications to the Counter subsystem userspace interface,
> so existing userspace applications should continue to run seamlessly.
Hi William

Been a while since I looked at this series.  Its rather big and I'm lazy
(or busy depending on who I'm talking to :)

Hmm. I'm a bit in two minds about how you should handle the huge amount of
description here.  Some of it clearly belongs in the kernel docs (and some
is I think put there in a later patch).  Other parts are specific to
this series, but I'm not 100% sure this much detail is really useful in the
git log.   Note that we now have links to the threads for all patches applied
using b4 (which this will be) so it's fine to have really detailed stuff
in cover letters rather than the individual patches.

One thing that would be handy for review, might be if you put up a tree
somewhere with this applied and included a link.

Mind you I don't feel that strongly about it if it you do want to maintain
it in the individual patch descriptions.

I've been a bit lazy and not cropped this down as much as I ideally should
have done (to include only bits I'm commenting on).

Anyhow, various minor things inline but this fundamentally looks fine to me.

Jonathan


> 
> Overview
> ========
> 
> The purpose of this patch is to internalize the sysfs interface code
> among the various counter drivers into a shared module. Counter drivers
> pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> module handles the translation between the sysfs interface.

Confusing statement.  Between the sysfs interface and what?
Perhaps "handles the translation to/from the sysfs interface."

> This
> guarantees a standard userspace interface for all counter drivers, and
> helps generalize the Generic Counter driver ABI in order to support the
> Generic Counter chrdev interface (introduced in a subsequent patch)
> without significant changes to the existing counter drivers.
> 
> A high-level view of how a count value is passed down from a counter
> driver is exemplified by the following. The driver callbacks are first
> registered to the Counter core component for use by the Counter
> userspace interface components:
> 
>                         +----------------------------+
> 	                | Counter device driver      |

Looks like something snuck a tab in amongst your spaces.

>                         +----------------------------+
>                         | Processes data from device |
>                         +----------------------------+
>                                 |
>                          -------------------
>                         / driver callbacks /
>                         -------------------
>                                 |
>                                 V
>                         +----------------------+
>                         | Counter core         |
>                         +----------------------+
>                         | Routes device driver |
>                         | callbacks to the     |
>                         | userspace interfaces |
>                         +----------------------+
>                                 |
>                          -------------------
>                         / driver callbacks /
>                         -------------------
>                                 |
>                 +---------------+
>                 |
>                 V
>         +--------------------+
>         | Counter sysfs      |
>         +--------------------+
>         | Translates to the  |
>         | standard Counter   |
>         | sysfs output       |
>         +--------------------+
> 
> Thereafter, data can be transferred directly between the Counter device
> driver and Counter userspace interface:
> 
>                          ----------------------
>                         / Counter device       \
>                         +----------------------+
>                         | Count register: 0x28 |
>                         +----------------------+
>                                 |
>                          -----------------
>                         / raw count data /
>                         -----------------
>                                 |
>                                 V
>                         +----------------------------+
>                         | Counter device driver      |
>                         +----------------------------+
>                         | Processes data from device |
>                         |----------------------------|
>                         | Type: u64                  |
>                         | Value: 42                  |
>                         +----------------------------+
>                                 |
>                          ----------
>                         / u64     /
>                         ----------
>                                 |
>                 +---------------+
>                 |
>                 V
>         +--------------------+
>         | Counter sysfs      |
>         +--------------------+
>         | Translates to the  |
>         | standard Counter   |
>         | sysfs output       |
>         |--------------------|
>         | Type: const char * |
>         | Value: "42"        |
>         +--------------------+
>                 |
>          ---------------
>         / const char * /
>         ---------------
>                 |
>                 V
>         +--------------------------------------------------+
>         | `/sys/bus/counter/devices/counterX/countY/count` |
>         +--------------------------------------------------+
>         \ Count: "42"                                      /
>          --------------------------------------------------
> 
> There are three primary components involved:
> 
> Counter device driver
> ---------------------
> Communicates with the hardware device to read/write data; e.g. counter
> drivers for quadrature encoders, timers, etc.
> 
> Counter core
> ------------
> Registers the counter device driver to the system so that the respective
> callbacks are called during userspace interaction.
> 
> Counter sysfs
> -------------
> Translates counter data to the standard Counter sysfs interface format
> and vice versa.
> 
> Driver ABI
> ==========
> 
> This reimplementation entails several changes to the driver ABI. In
> particular, the device driver callbacks are now expected to handle
> standard C datatypes rather than translating the sysfs I/O directly.
> 
> To that end, the struct counter_comp structure is introduced to
> establish counter extensions for Signals, Synapses, and Counts.
> 
> The "type" member specifies the type of high-level data (e.g. BOOL,
> COUNT_DIRECTION, etc.) handled by this extension. The "*_read" and
> "*_write" members can then be set by the counter device driver with
> callbacks to handle that data using native C data types (i.e. u8, u64,
> etc.).
> 
> Convenience macros such as COUNTER_COMP_COUNT_U64 are provided for use
> by driver authors. In particular, driver authors are expected to use
> the provided macros for standard Counter subsystem attributes in order
> to maintain a consistent interface for userspace. For example, a counter
> device driver may define several standard attributes like so:
> 
> struct counter_comp count_ext[] = {
> 	COUNTER_COMP_DIRECTION(count_direction_read),
> 	COUNTER_COMP_ENABLE(count_enable_read, count_enable_write),
> 	COUNTER_COMP_CEILING(count_ceiling_read, count_ceiling_write),
> };
> 
> This makes it simple to see, add, and modify the attributes that are
> supported by this driver ("direction", "enable", and "ceiling") and to
> maintain this code without getting lost in a web of struct braces.
> 
> Callbacks must match the function type expected for the respective
> component or extension. These function types are defined in the struct
> counter_comp structure as the "*_read" and "*_write" union members.
> 
> The corresponding callback prototypes for the extensions above would be:
> 
> int count_direction_read(struct counter_device *counter,
> 			 struct counter_count *count, u8 *direction);
> int count_enable_read(struct counter_device *counter,
> 		      struct counter_count *count, u8 *enable);
> int count_enable_write(struct counter_device *counter,
> 		       struct counter_count *count, u8 enable);
> int count_ceiling_read(struct counter_device *counter,
> 		       struct counter_count *count, u64 *ceiling);
> int count_ceiling_write(struct counter_device *counter,
> 			struct counter_count *count, u64 ceiling);
> 
> In this way, driver authors no longer need to mess with sysfs strings
> and are instead able to focus on what they actually care about doing --
> getting data to/from the devices -- while the Generic Counter interface
> handles the translation of that data for them between the various
> userspace interfaces (e.g. sysfs and chardev).
> 
> Architecture
> ============
> 
> Counter device registration is the same as before: drivers populate a
> struct counter_device with components and callbacks, then pass the
> structure to the devm_counter_register function. However, what's
> different now is how the Counter subsystem code handles this
> registration internally.
> 
> Whereas before callbacks would interact directly with sysfs data, this
> interaction is now abstracted and instead callbacks interact with native
> C data types. The counter_comp structure forms the basis for Counter
> extensions.
> 
> The counter-sysfs.c file contains the code to parse through the
> counter_device structure and register the requested components and
> extensions. Attributes are created and populated based on type, with
> respective translation functions to handle the mapping between sysfs and
> the counter driver callbacks.
> 
> The translation performed for each attribute is straightforward: the
> attribute type and data is parsed from the counter_attribute structure,
> the respective counter driver read/write callback is called, and sysfs
> I/O is handled before or after the driver read/write function is called.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS                             |    1 -
>  drivers/counter/104-quad-8.c            |  489 ++++----
>  drivers/counter/Makefile                |    1 +
>  drivers/counter/counter-core.c          |  153 +++
>  drivers/counter/counter-sysfs.c         |  837 +++++++++++++
>  drivers/counter/counter-sysfs.h         |   13 +
>  drivers/counter/counter.c               | 1496 -----------------------
>  drivers/counter/ftm-quaddec.c           |   61 +-
>  drivers/counter/microchip-tcb-capture.c |  103 +-
>  drivers/counter/stm32-lptimer-cnt.c     |  181 +--
>  drivers/counter/stm32-timer-cnt.c       |  149 +--
>  drivers/counter/ti-eqep.c               |  224 ++--
>  include/linux/counter.h                 |  707 +++++------
>  include/linux/counter_enum.h            |   45 -
>  14 files changed, 1932 insertions(+), 2528 deletions(-)
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ac5688db43a..b64fa49d5796 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4494,7 +4494,6 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
>  F:	Documentation/driver-api/generic-counter.rst
>  F:	drivers/counter/
>  F:	include/linux/counter.h
> -F:	include/linux/counter_enum.h
>  
>  CPMAC ETHERNET DRIVER
>  M:	Florian Fainelli <f.fainelli@gmail.com>
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 78766b6ec271..f4fb36b751c4 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -621,7 +621,8 @@ static const struct iio_chan_spec quad8_channels[] = {
>  };
>  
>  static int quad8_signal_read(struct counter_device *counter,
> -	struct counter_signal *signal, enum counter_signal_value *val)
> +			     struct counter_signal *signal,
> +			     enum counter_signal_level *level)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  	unsigned int state;
> @@ -633,13 +634,13 @@ static int quad8_signal_read(struct counter_device *counter,
>  	state = inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
>  		& BIT(signal->id - 16);
>  
> -	*val = (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> +	*level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;

This bit of refactoring / renaming could have been split out as a precursor patch
I think.  There may be other opportunities. 

>  
>  	return 0;
>  }
>  
>  static int quad8_count_read(struct counter_device *counter,
> -	struct counter_count *count, unsigned long *val)
> +			    struct counter_count *count, u64 *val)

Could the type change for val have been done as a precursor?

>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id;
> @@ -670,7 +671,7 @@ static int quad8_count_read(struct counter_device *counter,
>  }
>  
>  static int quad8_count_write(struct counter_device *counter,
> -	struct counter_count *count, unsigned long val)
> +			     struct counter_count *count, u64 val)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id;
> @@ -710,22 +711,17 @@ static int quad8_count_write(struct counter_device *counter,
>  	return 0;
>  }
>  
> -enum quad8_count_function {
> -	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION = 0,
> -	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
> -	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
> -	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
> -};
>  
> -static enum counter_count_function quad8_count_functions_list[] = {
> -	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> +static const enum counter_function quad8_functions_list[] = {
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
> -static int quad8_function_get(struct counter_device *counter,
> -	struct counter_count *count, size_t *function)
> +static int quad8_function_read(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       enum counter_function *function)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const int id = count->id;
> @@ -735,25 +731,26 @@ static int quad8_function_get(struct counter_device *counter,
>  	if (priv->quadrature_mode[id])
>  		switch (priv->quadrature_scale[id]) {
>  		case 0:
> -			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
> +			*function = COUNTER_FUNCTION_QUADRATURE_X1_A;
>  			break;
>  		case 1:
> -			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
> +			*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
>  			break;
>  		case 2:
> -			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
> +			*function = COUNTER_FUNCTION_QUADRATURE_X4;
>  			break;
>  		}
>  	else
> -		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> +		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
>  
>  	mutex_unlock(&priv->lock);
>  
>  	return 0;
>  }
>  
> -static int quad8_function_set(struct counter_device *counter,
> -	struct counter_count *count, size_t function)
> +static int quad8_function_write(struct counter_device *counter,
> +				struct counter_count *count,
> +				enum counter_function function)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const int id = count->id;
> @@ -769,7 +766,7 @@ static int quad8_function_set(struct counter_device *counter,
>  	mode_cfg = priv->count_mode[id] << 1;
>  	idr_cfg = priv->index_polarity[id] << 1;
>  
> -	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
> +	if (function == COUNTER_FUNCTION_PULSE_DIRECTION) {
>  		*quadrature_mode = 0;
>  
>  		/* Quadrature scaling only available in quadrature mode */
> @@ -785,18 +782,21 @@ static int quad8_function_set(struct counter_device *counter,
>  		*quadrature_mode = 1;
>  
>  		switch (function) {
> -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> +		case COUNTER_FUNCTION_QUADRATURE_X1_A:
>  			*scale = 0;
>  			mode_cfg |= QUAD8_CMR_QUADRATURE_X1;
>  			break;
> -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> +		case COUNTER_FUNCTION_QUADRATURE_X2_A:
>  			*scale = 1;
>  			mode_cfg |= QUAD8_CMR_QUADRATURE_X2;
>  			break;
> -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> +		case COUNTER_FUNCTION_QUADRATURE_X4:
>  			*scale = 2;
>  			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
>  			break;
> +		default:
> +			mutex_unlock(&priv->lock);
> +			return -EINVAL;

This looks like a sensible precaution / cleanup but could have been
done separately to the rest of the patch I think?

>  		}
>  	}
>  
> @@ -808,8 +808,9 @@ static int quad8_function_set(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static void quad8_direction_get(struct counter_device *counter,
> -	struct counter_count *count, enum counter_count_direction *direction)
> +static int quad8_direction_read(struct counter_device *counter,
> +				struct counter_count *count,
> +				enum counter_count_direction *direction)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  	unsigned int ud_flag;
> @@ -820,77 +821,78 @@ static void quad8_direction_get(struct counter_device *counter,
>  
>  	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
>  		COUNTER_COUNT_DIRECTION_BACKWARD;
> -}
>  
> -enum quad8_synapse_action {
> -	QUAD8_SYNAPSE_ACTION_NONE = 0,
> -	QUAD8_SYNAPSE_ACTION_RISING_EDGE,
> -	QUAD8_SYNAPSE_ACTION_FALLING_EDGE,
> -	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
> -};
> +	return 0;
> +}
>  
> -static enum counter_synapse_action quad8_index_actions_list[] = {
> -	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
> -	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
> +static const enum counter_synapse_action quad8_index_actions_list[] = {
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  };
>  
> -static enum counter_synapse_action quad8_synapse_actions_list[] = {
> -	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
> -	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> -	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> -	[QUAD8_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
> +static const enum counter_synapse_action quad8_synapse_actions_list[] = {
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
>  };
>  
> -static int quad8_action_get(struct counter_device *counter,
> -	struct counter_count *count, struct counter_synapse *synapse,
> -	size_t *action)
> +static int quad8_action_read(struct counter_device *counter,
> +			     struct counter_count *count,
> +			     struct counter_synapse *synapse,
> +			     enum counter_synapse_action *action)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	int err;
> -	size_t function = 0;
> +	enum counter_function function;
>  	const size_t signal_a_id = count->synapses[0].signal->id;
>  	enum counter_count_direction direction;
>  
>  	/* Handle Index signals */
>  	if (synapse->signal->id >= 16) {
>  		if (priv->preset_enable[count->id])
> -			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>  		else
> -			*action = QUAD8_SYNAPSE_ACTION_NONE;
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
>  
>  		return 0;
>  	}
>  
> -	err = quad8_function_get(counter, count, &function);
> +	err = quad8_function_read(counter, count, &function);
>  	if (err)
>  		return err;
>  
>  	/* Default action mode */
> -	*action = QUAD8_SYNAPSE_ACTION_NONE;
> +	*action = COUNTER_SYNAPSE_ACTION_NONE;
>  
>  	/* Determine action mode based on current count function mode */
>  	switch (function) {
> -	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
>  		if (synapse->signal->id == signal_a_id)
> -			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>  		break;
> -	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
>  		if (synapse->signal->id == signal_a_id) {
> -			quad8_direction_get(counter, count, &direction);
> +			err = quad8_direction_read(counter, count, &direction);
> +			if (err)
> +				return err;
>  
>  			if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
> -				*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>  			else
> -				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
> +				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
>  		}
>  		break;
> -	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
>  		if (synapse->signal->id == signal_a_id)
> -			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>  		break;
> -	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> -		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>  		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
>  
>  	return 0;
> @@ -900,13 +902,14 @@ static const struct counter_ops quad8_ops = {
>  	.signal_read = quad8_signal_read,
>  	.count_read = quad8_count_read,
>  	.count_write = quad8_count_write,
> -	.function_get = quad8_function_get,
> -	.function_set = quad8_function_set,
> -	.action_get = quad8_action_get
> +	.function_read = quad8_function_read,
> +	.function_write = quad8_function_write,
> +	.action_read = quad8_action_read
>  };
>  
>  static int quad8_index_polarity_get(struct counter_device *counter,
> -	struct counter_signal *signal, size_t *index_polarity)
> +				    struct counter_signal *signal,
> +				    u32 *index_polarity)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id - 16;
> @@ -917,7 +920,8 @@ static int quad8_index_polarity_get(struct counter_device *counter,
>  }
>  
>  static int quad8_index_polarity_set(struct counter_device *counter,
> -	struct counter_signal *signal, size_t index_polarity)
> +				    struct counter_signal *signal,
> +				    u32 index_polarity)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id - 16;
> @@ -938,15 +942,9 @@ static int quad8_index_polarity_set(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static struct counter_signal_enum_ext quad8_index_pol_enum = {
> -	.items = quad8_index_polarity_modes,
> -	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
> -	.get = quad8_index_polarity_get,
> -	.set = quad8_index_polarity_set
> -};
> -
>  static int quad8_synchronous_mode_get(struct counter_device *counter,
> -	struct counter_signal *signal, size_t *synchronous_mode)
> +				      struct counter_signal *signal,
> +				      u32 *synchronous_mode)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id - 16;
> @@ -957,7 +955,8 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
>  }
>  
>  static int quad8_synchronous_mode_set(struct counter_device *counter,
> -	struct counter_signal *signal, size_t synchronous_mode)
> +				      struct counter_signal *signal,
> +				      u32 synchronous_mode)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id - 16;
> @@ -984,22 +983,18 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static struct counter_signal_enum_ext quad8_syn_mode_enum = {
> -	.items = quad8_synchronous_modes,
> -	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
> -	.get = quad8_synchronous_mode_get,
> -	.set = quad8_synchronous_mode_set
> -};
> -
> -static ssize_t quad8_count_floor_read(struct counter_device *counter,
> -	struct counter_count *count, void *private, char *buf)
> +static int quad8_count_floor_read(struct counter_device *counter,
> +				  struct counter_count *count, u64 *floor)
>  {
>  	/* Only a floor of 0 is supported */
> -	return sprintf(buf, "0\n");
> +	*floor = 0;
> +
> +	return 0;
>  }
>  
> -static int quad8_count_mode_get(struct counter_device *counter,
> -	struct counter_count *count, size_t *cnt_mode)
> +static int quad8_count_mode_read(struct counter_device *counter,
> +				 struct counter_count *count,
> +				 enum counter_count_mode *cnt_mode)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  
> @@ -1022,35 +1017,39 @@ static int quad8_count_mode_get(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static int quad8_count_mode_set(struct counter_device *counter,
> -	struct counter_count *count, size_t cnt_mode)
> +static int quad8_count_mode_write(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  enum counter_count_mode cnt_mode)
>  {
>  	struct quad8_iio *const priv = counter->priv;
> +	unsigned int count_mode;
>  	unsigned int mode_cfg;
>  	const int base_offset = priv->base + 2 * count->id + 1;
>  
>  	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
>  	switch (cnt_mode) {
>  	case COUNTER_COUNT_MODE_NORMAL:
> -		cnt_mode = 0;
> +		count_mode = 0;
>  		break;
>  	case COUNTER_COUNT_MODE_RANGE_LIMIT:
> -		cnt_mode = 1;
> +		count_mode = 1;
>  		break;
>  	case COUNTER_COUNT_MODE_NON_RECYCLE:
> -		cnt_mode = 2;
> +		count_mode = 2;
>  		break;
>  	case COUNTER_COUNT_MODE_MODULO_N:
> -		cnt_mode = 3;
> +		count_mode = 3;
>  		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
>  	mutex_lock(&priv->lock);
>  
> -	priv->count_mode[count->id] = cnt_mode;
> +	priv->count_mode[count->id] = count_mode;
>  
>  	/* Set count mode configuration value */
> -	mode_cfg = cnt_mode << 1;
> +	mode_cfg = count_mode << 1;
>  
>  	/* Add quadrature mode configuration */
>  	if (priv->quadrature_mode[count->id])
> @@ -1064,60 +1063,39 @@ static int quad8_count_mode_set(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static struct counter_count_enum_ext quad8_cnt_mode_enum = {
> -	.items = counter_count_mode_str,
> -	.num_items = ARRAY_SIZE(counter_count_mode_str),
> -	.get = quad8_count_mode_get,
> -	.set = quad8_count_mode_set
> -};
> -
> -static ssize_t quad8_count_direction_read(struct counter_device *counter,
> -	struct counter_count *count, void *priv, char *buf)
> -{
> -	enum counter_count_direction dir;
> -
> -	quad8_direction_get(counter, count, &dir);
> -
> -	return sprintf(buf, "%s\n", counter_count_direction_str[dir]);
> -}
> -
> -static ssize_t quad8_count_enable_read(struct counter_device *counter,
> -	struct counter_count *count, void *private, char *buf)
> +static int quad8_count_enable_read(struct counter_device *counter,
> +				   struct counter_count *count, u8 *enable)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  
> -	return sprintf(buf, "%u\n", priv->ab_enable[count->id]);
> +	*enable = priv->ab_enable[count->id];
> +
> +	return 0;
>  }
>  
> -static ssize_t quad8_count_enable_write(struct counter_device *counter,
> -	struct counter_count *count, void *private, const char *buf, size_t len)
> +static int quad8_count_enable_write(struct counter_device *counter,
> +				    struct counter_count *count, u8 enable)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id;
> -	int err;
> -	bool ab_enable;
>  	unsigned int ior_cfg;
>  
> -	err = kstrtobool(buf, &ab_enable);
> -	if (err)
> -		return err;
> -
>  	mutex_lock(&priv->lock);
>  
> -	priv->ab_enable[count->id] = ab_enable;
> +	priv->ab_enable[count->id] = enable;
>  
> -	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
> +	ior_cfg = enable | priv->preset_enable[count->id] << 1;
>  
>  	/* Load I/O control configuration */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return 0;
>  }
>  
>  static int quad8_error_noise_get(struct counter_device *counter,
> -	struct counter_count *count, size_t *noise_error)
> +				 struct counter_count *count, u32 *noise_error)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id + 1;
> @@ -1127,22 +1105,18 @@ static int quad8_error_noise_get(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static struct counter_count_enum_ext quad8_error_noise_enum = {
> -	.items = quad8_noise_error_states,
> -	.num_items = ARRAY_SIZE(quad8_noise_error_states),
> -	.get = quad8_error_noise_get
> -};
> -
> -static ssize_t quad8_count_preset_read(struct counter_device *counter,
> -	struct counter_count *count, void *private, char *buf)
> +static int quad8_count_preset_read(struct counter_device *counter,
> +				   struct counter_count *count, u64 *preset)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  
> -	return sprintf(buf, "%u\n", priv->preset[count->id]);
> +	*preset = priv->preset[count->id];
> +
> +	return 0;
>  }
>  
> -static void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
> -		unsigned int preset)
> +static void quad8_preset_register_set(struct quad8_iio *const quad8iio,
> +				      const int id, const u64 preset)
>  {
>  	const unsigned int base_offset = quad8iio->base + 2 * id;
>  	int i;
> @@ -1157,16 +1131,10 @@ static void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
>  		outb(preset >> (8 * i), base_offset);
>  }
>  
> -static ssize_t quad8_count_preset_write(struct counter_device *counter,
> -	struct counter_count *count, void *private, const char *buf, size_t len)
> +static int quad8_count_preset_write(struct counter_device *counter,
> +				    struct counter_count *count, u64 preset)
>  {
>  	struct quad8_iio *const priv = counter->priv;
> -	unsigned int preset;
> -	int ret;
> -
> -	ret = kstrtouint(buf, 0, &preset);
> -	if (ret)
> -		return ret;
>  
>  	/* Only 24-bit values are supported */
>  	if (preset > 0xFFFFFF)
> @@ -1178,11 +1146,11 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
> -	struct counter_count *count, void *private, char *buf)
> +static int quad8_count_ceiling_read(struct counter_device *counter,
> +				    struct counter_count *count, u64 *ceiling)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  
> @@ -1192,26 +1160,23 @@ static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
>  	switch (priv->count_mode[count->id]) {
>  	case 1:
>  	case 3:
> -		mutex_unlock(&priv->lock);
> -		return sprintf(buf, "%u\n", priv->preset[count->id]);
> +		*ceiling = priv->preset[count->id];
> +		break;
> +	default:
> +		/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
> +		*ceiling = 0x1FFFFFF;
> +		break;
>  	}
>  
>  	mutex_unlock(&priv->lock);
>  
> -	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
> -	return sprintf(buf, "33554431\n");
> +	return 0;
>  }
>  
> -static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
> -	struct counter_count *count, void *private, const char *buf, size_t len)
> +static int quad8_count_ceiling_write(struct counter_device *counter,
> +				     struct counter_count *count, u64 ceiling)
>  {
>  	struct quad8_iio *const priv = counter->priv;
> -	unsigned int ceiling;
> -	int ret;
> -
> -	ret = kstrtouint(buf, 0, &ceiling);
> -	if (ret)
> -		return ret;
>  
>  	/* Only 24-bit values are supported */
>  	if (ceiling > 0xFFFFFF)
> @@ -1229,30 +1194,28 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return -EINVAL;

?  That looks like the good exit path to me.

>  }
>  
> -static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
> -	struct counter_count *count, void *private, char *buf)
> +static int quad8_count_preset_enable_read(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  u8 *preset_enable)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  
> -	return sprintf(buf, "%u\n", !priv->preset_enable[count->id]);
> +	*preset_enable = !priv->preset_enable[count->id];
> +
> +	return 0;
>  }
>  
> -static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
> -	struct counter_count *count, void *private, const char *buf, size_t len)
> +static int quad8_count_preset_enable_write(struct counter_device *counter,
> +					   struct counter_count *count,
> +					   u8 preset_enable)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id + 1;
> -	bool preset_enable;
> -	int ret;
>  	unsigned int ior_cfg;
>  
> -	ret = kstrtobool(buf, &preset_enable);
> -	if (ret)
> -		return ret;
> -
>  	/* Preset enable is active low in Input/Output Control register */
>  	preset_enable = !preset_enable;
>  
> @@ -1260,25 +1223,24 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
>  
>  	priv->preset_enable[count->id] = preset_enable;
>  
> -	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
> +	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1;
>  
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
> -					     struct counter_signal *signal,
> -					     void *private, char *buf)
> +static int quad8_signal_cable_fault_read(struct counter_device *counter,
> +					 struct counter_signal *signal,
> +					 u8 *cable_fault)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id / 2;
>  	bool disabled;
>  	unsigned int status;
> -	unsigned int fault;
>  
>  	mutex_lock(&priv->lock);
>  
> @@ -1295,36 +1257,31 @@ static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
>  	mutex_unlock(&priv->lock);
>  
>  	/* Mask respective channel and invert logic */
> -	fault = !(status & BIT(channel_id));
> +	*cable_fault = !(status & BIT(channel_id));
>  
> -	return sprintf(buf, "%u\n", fault);
> +	return 0;
>  }
>  
> -static ssize_t quad8_signal_cable_fault_enable_read(
> -	struct counter_device *counter, struct counter_signal *signal,
> -	void *private, char *buf)
> +static int quad8_signal_cable_fault_enable_read(struct counter_device *counter,
> +						struct counter_signal *signal,
> +						u8 *enable)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id / 2;
> -	const unsigned int enb = !!(priv->cable_fault_enable & BIT(channel_id));
>  
> -	return sprintf(buf, "%u\n", enb);
> +	*enable = !!(priv->cable_fault_enable & BIT(channel_id));
> +
> +	return 0;
>  }
>  
> -static ssize_t quad8_signal_cable_fault_enable_write(
> -	struct counter_device *counter, struct counter_signal *signal,
> -	void *private, const char *buf, size_t len)
> +static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
> +						 struct counter_signal *signal,
> +						 u8 enable)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id / 2;
> -	bool enable;
> -	int ret;
>  	unsigned int cable_fault_enable;
>  
> -	ret = kstrtobool(buf, &enable);
> -	if (ret)
> -		return ret;
> -
>  	mutex_lock(&priv->lock);
>  
>  	if (enable)
> @@ -1339,31 +1296,27 @@ static ssize_t quad8_signal_cable_fault_enable_write(
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *counter,
> -	struct counter_signal *signal, void *private, char *buf)
> +static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
> +					   struct counter_signal *signal,
> +					   u8 *prescaler)
>  {
>  	const struct quad8_iio *const priv = counter->priv;
> -	const size_t channel_id = signal->id / 2;
>  
> -	return sprintf(buf, "%u\n", priv->fck_prescaler[channel_id]);
> +	*prescaler = priv->fck_prescaler[signal->id / 2];
> +
> +	return 0;
>  }
>  
> -static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
> -	struct counter_signal *signal, void *private, const char *buf,
> -	size_t len)
> +static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
> +					    struct counter_signal *signal,
> +					    u8 prescaler)
>  {
>  	struct quad8_iio *const priv = counter->priv;
>  	const size_t channel_id = signal->id / 2;
>  	const int base_offset = priv->base + 2 * channel_id;
> -	u8 prescaler;
> -	int ret;
> -
> -	ret = kstrtou8(buf, 0, &prescaler);
> -	if (ret)
> -		return ret;
>  
>  	mutex_lock(&priv->lock);
>  
> @@ -1379,31 +1332,30 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return 0;
>  }
>  
> -static const struct counter_signal_ext quad8_signal_ext[] = {
> -	{
> -		.name = "cable_fault",
> -		.read = quad8_signal_cable_fault_read
> -	},
> -	{
> -		.name = "cable_fault_enable",
> -		.read = quad8_signal_cable_fault_enable_read,
> -		.write = quad8_signal_cable_fault_enable_write
> -	},
> -	{
> -		.name = "filter_clock_prescaler",
> -		.read = quad8_signal_fck_prescaler_read,
> -		.write = quad8_signal_fck_prescaler_write
> -	}
> +static struct counter_comp quad8_signal_ext[] = {
> +	COUNTER_COMP_SIGNAL_BOOL("cable_fault", quad8_signal_cable_fault_read,
> +				 NULL),
> +	COUNTER_COMP_SIGNAL_BOOL("cable_fault_enable",
> +				 quad8_signal_cable_fault_enable_read,
> +				 quad8_signal_cable_fault_enable_write),
> +	COUNTER_COMP_SIGNAL_U8("filter_clock_prescaler",
> +			       quad8_signal_fck_prescaler_read,
> +			       quad8_signal_fck_prescaler_write)
>  };
>  
> -static const struct counter_signal_ext quad8_index_ext[] = {
> -	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
> -	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum),
> -	COUNTER_SIGNAL_ENUM("synchronous_mode", &quad8_syn_mode_enum),
> -	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enum)
> +static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_modes);
> +static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_modes);
> +
> +static struct counter_comp quad8_index_ext[] = {
> +	COUNTER_COMP_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
> +				 quad8_index_polarity_set,
> +				 quad8_index_pol_enum),
> +	COUNTER_COMP_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_get,
> +				 quad8_synchronous_mode_set,
> +				 quad8_synch_mode_enum),
>  };
>  
>  #define QUAD8_QUAD_SIGNAL(_id, _name) {		\
> @@ -1472,50 +1424,41 @@ static struct counter_synapse quad8_count_synapses[][3] = {
>  	QUAD8_COUNT_SYNAPSES(6), QUAD8_COUNT_SYNAPSES(7)
>  };
>  
> -static const struct counter_count_ext quad8_count_ext[] = {
> -	{
> -		.name = "ceiling",
> -		.read = quad8_count_ceiling_read,
> -		.write = quad8_count_ceiling_write
> -	},
> -	{
> -		.name = "floor",
> -		.read = quad8_count_floor_read
> -	},
> -	COUNTER_COUNT_ENUM("count_mode", &quad8_cnt_mode_enum),
> -	COUNTER_COUNT_ENUM_AVAILABLE("count_mode", &quad8_cnt_mode_enum),
> -	{
> -		.name = "direction",
> -		.read = quad8_count_direction_read
> -	},
> -	{
> -		.name = "enable",
> -		.read = quad8_count_enable_read,
> -		.write = quad8_count_enable_write
> -	},
> -	COUNTER_COUNT_ENUM("error_noise", &quad8_error_noise_enum),
> -	COUNTER_COUNT_ENUM_AVAILABLE("error_noise", &quad8_error_noise_enum),
> -	{
> -		.name = "preset",
> -		.read = quad8_count_preset_read,
> -		.write = quad8_count_preset_write
> -	},
> -	{
> -		.name = "preset_enable",
> -		.read = quad8_count_preset_enable_read,
> -		.write = quad8_count_preset_enable_write
> -	}
> +static const enum counter_count_mode quad8_cnt_modes[] = {
> +	COUNTER_COUNT_MODE_NORMAL,
> +	COUNTER_COUNT_MODE_RANGE_LIMIT,
> +	COUNTER_COUNT_MODE_NON_RECYCLE,
> +	COUNTER_COUNT_MODE_MODULO_N,
> +};
> +
> +static DEFINE_COUNTER_AVAILABLE(quad8_count_mode_available, quad8_cnt_modes);
> +
> +static DEFINE_COUNTER_ENUM(quad8_error_noise_enum, quad8_noise_error_states);
> +
> +static struct counter_comp quad8_count_ext[] = {
> +	COUNTER_COMP_CEILING(quad8_count_ceiling_read,
> +			     quad8_count_ceiling_write),
> +	COUNTER_COMP_FLOOR(quad8_count_floor_read, NULL),
> +	COUNTER_COMP_COUNT_MODE(quad8_count_mode_read, quad8_count_mode_write,
> +				quad8_count_mode_available),
> +	COUNTER_COMP_DIRECTION(quad8_direction_read),
> +	COUNTER_COMP_ENABLE(quad8_count_enable_read, quad8_count_enable_write),
> +	COUNTER_COMP_COUNT_ENUM("error_noise", quad8_error_noise_get, NULL,
> +				quad8_error_noise_enum),
> +	COUNTER_COMP_PRESET(quad8_count_preset_read, quad8_count_preset_write),
> +	COUNTER_COMP_PRESET_ENABLE(quad8_count_preset_enable_read,
> +				   quad8_count_preset_enable_write),
>  };
>  
> -#define QUAD8_COUNT(_id, _cntname) {					\
> -	.id = (_id),							\
> -	.name = (_cntname),						\
> -	.functions_list = quad8_count_functions_list,			\
> -	.num_functions = ARRAY_SIZE(quad8_count_functions_list),	\
> -	.synapses = quad8_count_synapses[(_id)],			\
> -	.num_synapses =	2,						\
> -	.ext = quad8_count_ext,						\
> -	.num_ext = ARRAY_SIZE(quad8_count_ext)				\
> +#define QUAD8_COUNT(_id, _cntname) {				\
> +	.id = (_id),						\
> +	.name = (_cntname),					\
> +	.functions_list = quad8_functions_list,			\
> +	.num_functions = ARRAY_SIZE(quad8_functions_list),	\
> +	.synapses = quad8_count_synapses[(_id)],		\
> +	.num_synapses =	2,					\
> +	.ext = quad8_count_ext,					\
> +	.num_ext = ARRAY_SIZE(quad8_count_ext)			\
>  }
>  
>  static struct counter_count quad8_counts[] = {
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 0a393f71e481..cbe1d06af6a9 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  obj-$(CONFIG_COUNTER) += counter.o
> +counter-y := counter-core.o counter-sysfs.o
>  
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> new file mode 100644
> index 000000000000..78e07588717b
> --- /dev/null
> +++ b/drivers/counter/counter-core.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic Counter interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#include <linux/counter.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/gfp.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include "counter-sysfs.h"
> +
> +/* Provides a unique ID for each counter device */
> +static DEFINE_IDA(counter_ida);
> +
> +static void counter_device_release(struct device *dev)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	counter_chrdev_remove(counter);
> +	ida_simple_remove(&counter_ida, counter->id);
> +}
> +
> +static struct device_type counter_device_type = {
> +	.name = "counter_device",
> +	.release = counter_device_release
> +};
> +
> +static struct bus_type counter_bus_type = {
> +	.name = "counter"
> +};
> +
> +/**
> + * counter_register - register Counter to the system
> + * @counter:	pointer to Counter to register
> + *
> + * This function registers a Counter to the system. A sysfs "counter" directory
> + * will be created and populated with sysfs attributes correlating with the
> + * Counter Signals, Synapses, and Counts respectively.

Where easy to do it's worth documenting return values.

> + */
> +int counter_register(struct counter_device *const counter)
> +{
> +	struct device *const dev = &counter->dev;
> +	int err;
> +
> +	/* Acquire unique ID */
> +	counter->id = ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> +	if (counter->id < 0)
> +		return counter->id;
> +
> +	/* Configure device structure for Counter */
> +	dev->type = &counter_device_type;
> +	dev->bus = &counter_bus_type;
> +	if (counter->parent) {
> +		dev->parent = counter->parent;
> +		dev->of_node = counter->parent->of_node;
> +	}
> +	dev_set_name(dev, "counter%d", counter->id);
> +	device_initialize(dev);
> +	dev_set_drvdata(dev, counter);
> +
> +	/* Add Counter sysfs attributes */
> +	err = counter_sysfs_add(counter);
> +	if (err < 0)
> +		goto err_free_id;
> +
> +	/* Add device to system */
> +	err = device_add(dev);
> +	if (err < 0)
> +		goto err_free_id;
> +
> +	return 0;
> +
> +err_free_id:
> +	put_device(dev);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(counter_register);
> +
> +/**
> + * counter_unregister - unregister Counter from the system
> + * @counter:	pointer to Counter to unregister
> + *
> + * The Counter is unregistered from the system; all allocated memory is freed.
> + */
> +void counter_unregister(struct counter_device *const counter)
> +{
> +	if (!counter)
> +		return;
> +
> +	device_unregister(&counter->dev);
> +}
> +EXPORT_SYMBOL_GPL(counter_unregister);
> +
> +static void devm_counter_unregister(struct device *dev, void *res)
> +{
> +	counter_unregister(*(struct counter_device **)res);

Rename this. It looks like it's a generic way of unwinding
devm_counter_register which it is definitely not...


> +}
> +
> +/**
> + * devm_counter_register - Resource-managed counter_register
> + * @dev:	device to allocate counter_device for
> + * @counter:	pointer to Counter to register
> + *
> + * Managed counter_register. The Counter registered with this function is
> + * automatically unregistered on driver detach. This function calls
> + * counter_register internally. Refer to that function for more information.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_counter_register(struct device *dev,
> +			  struct counter_device *const counter)
> +{
> +	struct counter_device **ptr;
> +	int err;
> +
> +	ptr = devres_alloc(devm_counter_unregister, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	err = counter_register(counter);
> +	if (err < 0) {
> +		devres_free(ptr);
> +		return err;
> +	}
> +
> +	*ptr = counter;
> +	devres_add(dev, ptr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_counter_register);
> +
> +static int __init counter_init(void)
> +{
> +	return bus_register(&counter_bus_type);
> +}
> +
> +static void __exit counter_exit(void)
> +{
> +	bus_unregister(&counter_bus_type);
> +}
> +
> +subsys_initcall(counter_init);
> +module_exit(counter_exit);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Generic Counter interface");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> new file mode 100644
> index 000000000000..654afa91ae9f
> --- /dev/null
> +++ b/drivers/counter/counter-sysfs.c
> @@ -0,0 +1,837 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic Counter sysfs interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#include <linux/counter.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include "counter-sysfs.h"
> +
> +/**
> + * struct counter_attribute - Counter sysfs attribute
> + * @dev_attr:	device attribute for sysfs
> + * @l:		node to add Counter attribute to attribute group list
> + * @comp:	Counter component callbacks and data
> + * @scope:	Counter scope of the attribute
> + * @parent:	pointer to the parent component
> + */
> +struct counter_attribute {
> +	struct device_attribute dev_attr;
> +	struct list_head l;
> +
> +	struct counter_comp comp;
> +	__u8 scope;

Why not an enum?

> +	void *parent;
> +};
> +
> +#define to_counter_attribute(_dev_attr) \
> +	container_of(_dev_attr, struct counter_attribute, dev_attr)
> +
> +/**
> + * struct counter_attribute_group - container for attribute group
> + * @name:	name of the attribute group
> + * @attr_list:	list to keep track of created attributes
> + * @num_attr:	number of attributes
> + */
> +struct counter_attribute_group {
> +	const char *name;
> +	struct list_head attr_list;
> +	size_t num_attr;
> +};
> +
> +static const char *const counter_function_str[] = {
> +	[COUNTER_FUNCTION_INCREASE] = "increase",
> +	[COUNTER_FUNCTION_DECREASE] = "decrease",
> +	[COUNTER_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
> +	[COUNTER_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
> +	[COUNTER_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
> +	[COUNTER_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
> +	[COUNTER_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
> +	[COUNTER_FUNCTION_QUADRATURE_X4] = "quadrature x4"
> +};
> +
> +static const char *const counter_signal_value_str[] = {
> +	[COUNTER_SIGNAL_LEVEL_LOW] = "low",
> +	[COUNTER_SIGNAL_LEVEL_HIGH] = "high"
> +};
> +
> +static const char *const counter_synapse_action_str[] = {
> +	[COUNTER_SYNAPSE_ACTION_NONE] = "none",
> +	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] = "rising edge",
> +	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] = "falling edge",
> +	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] = "both edges"
> +};
> +
> +static const char *const counter_count_direction_str[] = {
> +	[COUNTER_COUNT_DIRECTION_FORWARD] = "forward",
> +	[COUNTER_COUNT_DIRECTION_BACKWARD] = "backward"
> +};
> +
> +static const char *const counter_count_mode_str[] = {
> +	[COUNTER_COUNT_MODE_NORMAL] = "normal",
> +	[COUNTER_COUNT_MODE_RANGE_LIMIT] = "range limit",
> +	[COUNTER_COUNT_MODE_NON_RECYCLE] = "non-recycle",
> +	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
> +};
> +
> +static ssize_t counter_comp_u8_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	int err;
> +	u8 data = 0;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u8_read(counter, &data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u8_read(counter, a->parent, &data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		err = a->comp.count_u8_read(counter, a->parent, &data);
> +		break;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	if (a->comp.type == COUNTER_COMP_BOOL)
> +		data = !!data;
> +
> +	return sprintf(buf, "%u\n", (unsigned int)data);
> +}
> +
> +static ssize_t counter_comp_u8_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	int err;
> +	bool bool_data = 0;
> +	u8 data = 0;
> +
> +	if (a->comp.type == COUNTER_COMP_BOOL) {
> +		err = kstrtobool(buf, &bool_data);
> +		data = bool_data;
> +	} else
> +		err = kstrtou8(buf, 0, &data);
> +	if (err < 0)
> +		return err;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u8_write(counter, data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u8_write(counter, a->parent, data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		err = a->comp.count_u8_write(counter, a->parent, data);
> +		break;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	return len;
> +}
> +
> +static ssize_t counter_comp_u32_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_available *const avail = a->comp.priv;
> +	int err;
> +	u32 data = 0;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u32_read(counter, &data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u32_read(counter, a->parent, &data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		if (a->comp.type == COUNTER_COMP_SYNAPSE_ACTION)
> +			err = a->comp.action_read(counter, a->parent,
> +						  a->comp.priv, &data);
> +		else
> +			err = a->comp.count_u32_read(counter, a->parent, &data);
> +		break;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	switch (a->comp.type) {
> +	case COUNTER_COMP_FUNCTION:
> +		return sprintf(buf, "%s\n", counter_function_str[data]);
> +	case COUNTER_COMP_SIGNAL_LEVEL:
> +		return sprintf(buf, "%s\n", counter_signal_value_str[data]);
> +	case COUNTER_COMP_SYNAPSE_ACTION:
> +		return sprintf(buf, "%s\n", counter_synapse_action_str[data]);
> +	case COUNTER_COMP_ENUM:
> +		return sprintf(buf, "%s\n", avail->strs[data]);
> +	case COUNTER_COMP_COUNT_DIRECTION:
> +		return sprintf(buf, "%s\n", counter_count_direction_str[data]);
> +	case COUNTER_COMP_COUNT_MODE:
> +		return sprintf(buf, "%s\n", counter_count_mode_str[data]);
> +	default:

Perhaps move the below return sprintf() up here?

> +		break;
> +	}
> +
> +	return sprintf(buf, "%u\n", (unsigned int)data);
> +}
> +
> +static int find_in_string_array(u32 *const enum_item, const u32 *const enums,
> +				const size_t num_enums, const char *const buf,
> +				const char *const string_array[])

Please avoid defining such generically named functions.  High chance of a clash
with something that turns up in generic headers sometime in the future.

> +{
> +	size_t index;
> +
> +	for (index = 0; index < num_enums; index++) {
> +		*enum_item = enums[index];
> +		if (sysfs_streq(buf, string_array[*enum_item]))
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t counter_comp_u32_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = a->parent;
> +	struct counter_synapse *const synapse = a->comp.priv;
> +	const struct counter_available *const avail = a->comp.priv;
> +	int err;
> +	u32 data = 0;
> +
> +	switch (a->comp.type) {
> +	case COUNTER_COMP_FUNCTION:
> +		err = find_in_string_array(&data, count->functions_list,
> +					   count->num_functions, buf,
> +					   counter_function_str);
> +		break;
> +	case COUNTER_COMP_SYNAPSE_ACTION:
> +		err = find_in_string_array(&data, synapse->actions_list,
> +					   synapse->num_actions, buf,
> +					   counter_synapse_action_str);
> +		break;
> +	case COUNTER_COMP_ENUM:
> +		err = __sysfs_match_string(avail->strs, avail->num_items, buf);
> +		data = err;
> +		break;
> +	case COUNTER_COMP_COUNT_MODE:
> +		err = find_in_string_array(&data, avail->enums,
> +					   avail->num_items, buf,
> +					   counter_count_mode_str);
> +		break;
> +	default:
> +		err = kstrtou32(buf, 0, &data);
> +		break;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u32_write(counter, data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u32_write(counter, a->parent, data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		if (a->comp.type == COUNTER_COMP_SYNAPSE_ACTION)
> +			err = a->comp.action_write(counter, count, synapse,
> +						   data);
> +		else
> +			err = a->comp.count_u32_write(counter, count, data);
> +		break;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	return len;
> +}
> +
> +static ssize_t counter_comp_u64_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	int err;
> +	u64 data = 0;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u64_read(counter, &data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u64_read(counter, a->parent, &data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		err = a->comp.count_u64_read(counter, a->parent, &data);
> +		break;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	return sprintf(buf, "%llu\n", (unsigned long long)data);
> +}
> +
> +static ssize_t counter_comp_u64_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	int err;
> +	u64 data = 0;
> +
> +	err = kstrtou64(buf, 0, &data);
> +	if (err < 0)
> +		return err;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u64_write(counter, data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u64_write(counter, a->parent, data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		err = a->comp.count_u64_write(counter, a->parent, data);
> +		break;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	return len;
> +}
> +
> +static ssize_t enums_available_show(const u32 *const enums,
> +				    const size_t num_enums,
> +				    const char *const strs[], char *buf)
> +{
> +	size_t len = 0;
> +	size_t index;
> +
> +	for (index = 0; index < num_enums; index++)
> +		len += sprintf(buf + len, "%s\n", strs[enums[index]]);

Probably better to add protections on overrunning the buffer to this.
Sure it won't actually happen but that may not be obvious to someone reading
this code in future.

Look at new sysfs_emit * family for this.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2efc459d06f1630001e3984854848a5647086232

> +
> +	return len;
> +}
> +
> +static ssize_t strs_available_show(const struct counter_available *const avail,
> +				   char *buf)
> +{
> +	size_t len = 0;
> +	size_t index;
> +
> +	for (index = 0; index < avail->num_items; index++)
> +		len += sprintf(buf + len, "%s\n", avail->strs[index]);
> +
> +	return len;
> +}
> +
> +static ssize_t counter_comp_available_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	const struct counter_count *const count = a->parent;
> +	const struct counter_synapse *const synapse = a->comp.priv;
> +	const struct counter_available *const avail = a->comp.priv;
> +
> +	switch (a->comp.type) {
> +	case COUNTER_COMP_FUNCTION:
> +		return enums_available_show(count->functions_list,
> +					    count->num_functions,
> +					    counter_function_str, buf);
> +	case COUNTER_COMP_SYNAPSE_ACTION:
> +		return enums_available_show(synapse->actions_list,
> +					    synapse->num_actions,
> +					    counter_synapse_action_str, buf);
> +	case COUNTER_COMP_ENUM:
> +		return strs_available_show(avail, buf);
> +	case COUNTER_COMP_COUNT_MODE:
> +		return enums_available_show(avail->enums, avail->num_items,
> +					    counter_count_mode_str, buf);
> +	default:
> +		break;

Might as well return -EINVAL; here

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int counter_avail_attr_create(struct device *const dev,
> +	struct counter_attribute_group *const group,
> +	const struct counter_comp *const comp, void *const parent)
> +{
> +	struct counter_attribute *counter_attr;
> +	struct device_attribute *dev_attr;
> +
> +	/* Allocate Counter attribute */
> +	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
> +	if (!counter_attr)
> +		return -ENOMEM;
> +
> +	/* Configure Counter attribute */
> +	counter_attr->comp.type = comp->type;
> +	counter_attr->comp.priv = comp->priv;
> +	counter_attr->parent = parent;
> +
> +	/* Initialize sysfs attribute */
> +	dev_attr = &counter_attr->dev_attr;
> +	sysfs_attr_init(&dev_attr->attr);
> +
> +	/* Configure device attribute */
> +	dev_attr->attr.name = devm_kasprintf(dev, GFP_KERNEL, "%s_available",
> +					     comp->name);
> +	if (!dev_attr->attr.name)
> +		return -ENOMEM;
> +	dev_attr->attr.mode = 0444;
> +	dev_attr->show = counter_comp_available_show;
> +
> +	/* Store list node */
> +	list_add(&counter_attr->l, &group->attr_list);
> +	group->num_attr++;
> +
> +	return 0;
> +}
> +
> +static int counter_attr_create(struct device *const dev,
> +			       struct counter_attribute_group *const group,
> +			       const struct counter_comp *const comp,
> +			       const __u8 scope, void *const parent)
> +{
> +	struct counter_attribute *counter_attr;
> +	struct device_attribute *dev_attr;
> +
> +	/* Allocate Counter attribute */
> +	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
> +	if (!counter_attr)
> +		return -ENOMEM;
> +
> +	/* Configure Counter attribute */
> +	counter_attr->comp = *comp;
> +	counter_attr->scope = scope;
> +	counter_attr->parent = parent;
> +
> +	/* Configure device attribute */
> +	dev_attr = &counter_attr->dev_attr;
> +	sysfs_attr_init(&dev_attr->attr);
> +	dev_attr->attr.name = comp->name;
> +	switch (comp->type) {
> +	case COUNTER_COMP_U8:
> +	case COUNTER_COMP_BOOL:
> +		if (comp->device_u8_read) {
> +			dev_attr->attr.mode |= 0444;
> +			dev_attr->show = counter_comp_u8_show;
> +		}
> +		if (comp->device_u8_write) {
> +			dev_attr->attr.mode |= 0200;
> +			dev_attr->store = counter_comp_u8_store;
> +		}
> +		break;
> +	case COUNTER_COMP_SIGNAL_LEVEL:
> +	case COUNTER_COMP_FUNCTION:
> +	case COUNTER_COMP_SYNAPSE_ACTION:
> +	case COUNTER_COMP_ENUM:
> +	case COUNTER_COMP_COUNT_DIRECTION:
> +	case COUNTER_COMP_COUNT_MODE:
> +		if (comp->device_u32_read) {
> +			dev_attr->attr.mode |= 0444;
> +			dev_attr->show = counter_comp_u32_show;
> +		}
> +		if (comp->device_u32_write) {
> +			dev_attr->attr.mode |= 0200;
> +			dev_attr->store = counter_comp_u32_store;
> +		}
> +		break;
> +	case COUNTER_COMP_U64:
> +		if (comp->device_u64_read) {
> +			dev_attr->attr.mode |= 0444;
> +			dev_attr->show = counter_comp_u64_show;
> +		}
> +		if (comp->device_u64_write) {
> +			dev_attr->attr.mode |= 0200;
> +			dev_attr->store = counter_comp_u64_store;
> +		}
> +		break;
> +	}
> +
> +	/* Store list node */
> +	list_add(&counter_attr->l, &group->attr_list);
> +	group->num_attr++;
> +
> +	switch (comp->type) {
> +	case COUNTER_COMP_FUNCTION:
> +	case COUNTER_COMP_SYNAPSE_ACTION:
> +	case COUNTER_COMP_ENUM:
> +	case COUNTER_COMP_COUNT_MODE:
> +		return counter_avail_attr_create(dev, group, comp, parent);
> +	default:
> +		break;

return 0 in here.  Also add a comment on why it isn't an error.

> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t counter_comp_name_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%s\n", to_counter_attribute(attr)->comp.name);
> +}
> +
> +static int counter_name_attr_create(struct device *const dev,
> +				    struct counter_attribute_group *const group,
> +				    const char *const name)
> +{
> +	struct counter_attribute *counter_attr;
> +
> +	/* Allocate Counter attribute */
> +	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
> +	if (!counter_attr)
> +		return -ENOMEM;
> +
> +	/* Configure Counter attribute */
> +	counter_attr->comp.name = name;
> +
> +	/* Configure device attribute */
> +	sysfs_attr_init(&counter_attr->dev_attr.attr);
> +	counter_attr->dev_attr.attr.name = "name";
> +	counter_attr->dev_attr.attr.mode = 0444;
> +	counter_attr->dev_attr.show = counter_comp_name_show;
> +
> +	/* Store list node */
> +	list_add(&counter_attr->l, &group->attr_list);
> +	group->num_attr++;
> +
> +	return 0;
> +}
> +
> +
> +static struct counter_comp counter_signal_comp = {
> +	.type = COUNTER_COMP_SIGNAL_LEVEL,
> +	.name = "signal",
> +};
> +
> +static int counter_signal_attrs_create(struct counter_device *const counter,
> +	struct counter_attribute_group *const group,
> +	struct counter_signal *const signal)
> +{
> +	const __u8 scope = COUNTER_SCOPE_SIGNAL;
> +	struct device *const dev = &counter->dev;
> +	int err;
> +	struct counter_comp comp;
> +	size_t i;
> +
> +	/* Create main Signal attribute */
> +	comp = counter_signal_comp;
> +	comp.signal_u32_read = counter->ops->signal_read;
> +	err = counter_attr_create(dev, group, &comp, scope, signal);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create Signal name attribute */
> +	err = counter_name_attr_create(dev, group, signal->name);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0; i < signal->num_ext; i++) {
> +		err = counter_attr_create(dev, group, signal->ext + i, scope,
> +					  signal);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_sysfs_signals_add(struct counter_device *const counter,
> +	struct counter_attribute_group *const groups)
> +{
> +	size_t i;
> +	int err;
> +
> +	/* Add each Signal */
> +	for (i = 0; i < counter->num_signals; i++) {
> +		/* Generate Signal attribute directory name */
> +		groups[i].name = devm_kasprintf(&counter->dev, GFP_KERNEL,
> +						"signal%zu", i);
> +		if (!groups[i].name)
> +			return -ENOMEM;
> +
> +		/* Create all attributes associated with Signal */
> +		err = counter_signal_attrs_create(counter, groups + i,
> +						  counter->signals + i);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_sysfs_synapses_add(struct counter_device *const counter,
> +	struct counter_attribute_group *const group,
> +	struct counter_count *const count)
> +{
> +	const __u8 scope = COUNTER_SCOPE_COUNT;
> +	struct device *const dev = &counter->dev;
> +	size_t i;
> +	struct counter_synapse *synapse;
> +	size_t id;
> +	struct counter_comp comp;
> +	int err;
> +
> +	/* Add each Synapse */
> +	for (i = 0; i < count->num_synapses; i++) {
Could reduce scope and make code a bit more readable by
pulling

struct counter_synapse *synapse;
struct counter_comp comp;
size_t id;

and maybe other things in here.  Makes it clear their scope
is just within this loop.

> +		synapse = count->synapses + i;
> +
> +		/* Generate Synapse action name */
> +		id = synapse->signal - counter->signals;
> +		comp.name = devm_kasprintf(dev, GFP_KERNEL, "signal%zu_action",
> +					   id);
> +		if (!comp.name)
> +			return -ENOMEM;
> +
> +		/* Create action attribute */
> +		comp.type = COUNTER_COMP_SYNAPSE_ACTION;
> +		comp.action_read = counter->ops->action_read;
> +		comp.action_write = counter->ops->action_write;
> +		comp.priv = synapse;
> +		err = counter_attr_create(dev, group, &comp, scope, count);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct counter_comp counter_count_comp =
> +	COUNTER_COMP_COUNT_U64("count", NULL, NULL);
> +
> +static struct counter_comp counter_function_comp = {
> +	.type = COUNTER_COMP_FUNCTION,
> +	.name = "function",
> +};
> +
> +static int counter_count_attrs_create(struct counter_device *const counter,
> +	struct counter_attribute_group *const group,
> +	struct counter_count *const count)
> +{
> +	const __u8 scope = COUNTER_SCOPE_COUNT;
> +	struct device *const dev = &counter->dev;
> +	int err;
> +	struct counter_comp comp;
> +	size_t i;
> +
> +	/* Create main Count attribute */
> +	comp = counter_count_comp;
> +	comp.count_u64_read = counter->ops->count_read;
> +	comp.count_u64_write = counter->ops->count_write;
> +	err = counter_attr_create(dev, group, &comp, scope, count);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create Count name attribute */
> +	err = counter_name_attr_create(dev, group, count->name);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create Count function attribute */
> +	comp = counter_function_comp;
> +	comp.count_u32_read = counter->ops->function_read;
> +	comp.count_u32_write = counter->ops->function_write;
> +	err = counter_attr_create(dev, group, &comp, scope, count);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0; i < count->num_ext; i++) {
> +		err = counter_attr_create(dev, group, count->ext + i, scope,
> +					  count);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_sysfs_counts_add(struct counter_device *const counter,
> +	struct counter_attribute_group *const groups)
> +{
> +	size_t i;
> +	struct counter_count *count;
> +	int err;
> +
> +	/* Add each Count */
> +	for (i = 0; i < counter->num_counts; i++) {
> +		count = counter->counts + i;
> +
> +		/* Generate Count attribute directory name */
> +		groups[i].name = devm_kasprintf(&counter->dev, GFP_KERNEL,
> +						"count%zu", i);
> +		if (!groups[i].name)
> +			return -ENOMEM;
> +
> +		/* Add sysfs attributes of the Synapses */
> +		err = counter_sysfs_synapses_add(counter, groups + i, count);
> +		if (err < 0)
> +			return err;
> +
> +		/* Create all attributes associated with Count */
> +		err = counter_count_attrs_create(counter, groups + i, count);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_num_signals_read(struct counter_device *counter, u8 *val)
> +{
> +	*val = counter->num_signals;
> +	return 0;
> +}
> +
> +static int counter_num_counts_read(struct counter_device *counter, u8 *val)
> +{
> +	*val = counter->num_counts;
> +	return 0;
> +}
> +
> +static struct counter_comp counter_num_signals_comp =
> +	COUNTER_COMP_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
> +
> +static struct counter_comp counter_num_counts_comp =
> +	COUNTER_COMP_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
> +
> +static int counter_sysfs_attr_add(struct counter_device *const counter,
> +				  struct counter_attribute_group *group)
> +{
> +	const __u8 scope = COUNTER_SCOPE_DEVICE;
> +	struct device *const dev = &counter->dev;
> +	int err;
> +	size_t i;
> +
> +	/* Add Signals sysfs attributes */
> +	err = counter_sysfs_signals_add(counter, group);
> +	if (err < 0)
> +		return err;
> +	group += counter->num_signals;
> +
> +	/* Add Counts sysfs attributes */
> +	err = counter_sysfs_counts_add(counter, group);
> +	if (err < 0)
> +		return err;
> +	group += counter->num_counts;
> +
> +	/* Create name attribute */
> +	err = counter_name_attr_create(dev, group, counter->name);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create num_signals attribute */
> +	err = counter_attr_create(dev, group, &counter_num_signals_comp, scope,
> +				  NULL);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create num_counts attribute */
> +	err = counter_attr_create(dev, group, &counter_num_counts_comp, scope,
> +				  NULL);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0; i < counter->num_ext; i++) {
> +		err = counter_attr_create(dev, group, counter->ext + i, scope,
> +					  NULL);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * counter_sysfs_add - Adds Counter sysfs attributes to the device structure
> + * @counter:	Pointer to the Counter device structure
> + *
> + * Counter sysfs attributes are created and added to the respective device
> + * structure for later registration to the system. Resource-managed memory
> + * allocation is performed by this function, and this memory should be freed
> + * when no longer needed (automatically by a device_unregister call, or
> + * manually by a devres_release_all call).
> + */
> +int counter_sysfs_add(struct counter_device *const counter)
> +{
> +	struct device *const dev = &counter->dev;
> +	const size_t num_groups = counter->num_signals + counter->num_counts + 1;
> +	struct counter_attribute_group *groups;
> +	size_t i, j;
> +	int err;
> +	struct attribute_group *group;
> +	struct counter_attribute *p;
> +
> +	/* Allocate space for attribute groups (signals, counts, and ext) */
> +	groups = devm_kcalloc(dev, num_groups, sizeof(*groups), GFP_KERNEL);
> +	if (!groups)
> +		return -ENOMEM;
> +
> +	/* Initialize attribute lists */
> +	for (i = 0; i < num_groups; i++)
> +		INIT_LIST_HEAD(&groups[i].attr_list);
> +
> +	/* Add Counter device sysfs attributes */
> +	err = counter_sysfs_attr_add(counter, groups);
> +	if (err < 0)
> +		return err;
> +
> +	/* Allocate attribute groups for association with device */
> +	dev->groups = devm_kcalloc(dev, num_groups + 1, sizeof(*dev->groups),
> +				   GFP_KERNEL);
> +	if (!dev->groups)
> +		return -ENOMEM;
> +
> +	/* Prepare each group of attributes for association */
> +	for (i = 0; i < num_groups; i++) {
> +		/* Allocate space for attribute group */
> +		group = devm_kzalloc(dev, sizeof(*group), GFP_KERNEL);
> +		if (!group)
> +			return -ENOMEM;
> +		group->name = groups[i].name;
> +
> +		/* Allocate space for attribute pointers */
> +		group->attrs = devm_kcalloc(dev, groups[i].num_attr + 1,
> +					    sizeof(*group->attrs), GFP_KERNEL);
> +		if (!group->attrs)
> +			return -ENOMEM;
> +
> +		/* Add attribute pointers to attribute group */
> +		j = 0;
> +		list_for_each_entry(p, &groups[i].attr_list, l)
> +			group->attrs[j++] = &p->dev_attr.attr;
> +
> +		/* Associate attribute group */
> +		dev->groups[i] = group;
> +	}
> +
> +	return 0;
> +}

...

...

> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 9dbd5df4cd34..2f01e1fec857 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -6,417 +6,290 @@
>  #ifndef _COUNTER_H_
>  #define _COUNTER_H_
>  
> -#include <linux/counter_enum.h>
>  #include <linux/device.h>
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  
> +struct counter_device;
> +struct counter_count;
> +struct counter_synapse;
> +struct counter_signal;
> +
> +enum counter_comp_type {
> +	COUNTER_COMP_U8,
> +	COUNTER_COMP_U64,
> +	COUNTER_COMP_BOOL,
> +	COUNTER_COMP_SIGNAL_LEVEL,
> +	COUNTER_COMP_FUNCTION,
> +	COUNTER_COMP_SYNAPSE_ACTION,
> +	COUNTER_COMP_ENUM,
> +	COUNTER_COMP_COUNT_DIRECTION,
> +	COUNTER_COMP_COUNT_MODE,
> +};
> +
> +enum counter_scope {
> +	COUNTER_SCOPE_DEVICE,
> +	COUNTER_SCOPE_SIGNAL,
> +	COUNTER_SCOPE_COUNT,
> +};
> +
>  enum counter_count_direction {
> -	COUNTER_COUNT_DIRECTION_FORWARD = 0,
> -	COUNTER_COUNT_DIRECTION_BACKWARD
> +	COUNTER_COUNT_DIRECTION_FORWARD,
> +	COUNTER_COUNT_DIRECTION_BACKWARD,
>  };
> -extern const char *const counter_count_direction_str[2];
>  
>  enum counter_count_mode {
> -	COUNTER_COUNT_MODE_NORMAL = 0,
> +	COUNTER_COUNT_MODE_NORMAL,
>  	COUNTER_COUNT_MODE_RANGE_LIMIT,
>  	COUNTER_COUNT_MODE_NON_RECYCLE,
> -	COUNTER_COUNT_MODE_MODULO_N
> +	COUNTER_COUNT_MODE_MODULO_N,
>  };
> -extern const char *const counter_count_mode_str[4];
>  
> -struct counter_device;
> -struct counter_signal;
> +enum counter_function {
> +	COUNTER_FUNCTION_INCREASE,
> +	COUNTER_FUNCTION_DECREASE,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	COUNTER_FUNCTION_QUADRATURE_X1_B,
> +	COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
> +};
> +
> +enum counter_signal_level {
> +	COUNTER_SIGNAL_LEVEL_LOW,
> +	COUNTER_SIGNAL_LEVEL_HIGH,
> +};
> +
> +enum counter_synapse_action {
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +};
>  
>  /**
> - * struct counter_signal_ext - Counter Signal extensions
> - * @name:	attribute name
> - * @read:	read callback for this attribute; may be NULL
> - * @write:	write callback for this attribute; may be NULL
> - * @priv:	data private to the driver
> + * struct counter_comp - Counter component node
> + * @type:		Counter component data type
> + * @name:		device-specific component name
> + * @priv:		component-relevant data
> + * @action_read		Synapse action mode read callback. The read value of the
> + *			respective Synapse action mode should be passed back via
> + *			the action parameter.
> + * @device_u8_read	Device u8 component read callback. The read value of the
> + *			respective Device u8 component should be passed back via
> + *			the val parameter.
> + * @count_u8_read	Count u8 component read callback. The read value of the
> + *			respective Count u8 component should be passed back via
> + *			the val parameter.
> + * @signal_u8_read	Signal u8 component read callback. The read value of the
> + *			respective Signal u8 component should be passed back via
> + *			the val parameter.
> + * @device_u32_read	Device u32 component read callback. The read value of
> + *			the respective Device u32 component should be passed
> + *			back via the val parameter.
> + * @count_u32_read	Count u32 component read callback. The read value of the
> + *			respective Count u32 component should be passed back via
> + *			the val parameter.
> + * @signal_u32_read	Signal u32 component read callback. The read value of
> + *			the respective Signal u32 component should be passed
> + *			back via the val parameter.
> + * @device_u64_read	Device u64 component read callback. The read value of
> + *			the respective Device u64 component should be passed
> + *			back via the val parameter.
> + * @count_u64_read	Count u64 component read callback. The read value of the
> + *			respective Count u64 component should be passed back via
> + *			the val parameter.
> + * @signal_u64_read	Signal u64 component read callback. The read value of
> + *			the respective Signal u64 component should be passed
> + *			back via the val parameter.
> + * @action_write	Synapse action mode write callback. The write value of
> + *			the respective Synapse action mode is passed via the
> + *			action parameter.
> + * @device_u8_write	Device u8 component write callback. The write value of
> + *			the respective Device u8 component is passed via the val
> + *			parameter.
> + * @count_u8_write	Count u8 component write callback. The write value of
> + *			the respective Count u8 component is passed via the val
> + *			parameter.
> + * @signal_u8_write	Signal u8 component write callback. The write value of
> + *			the respective Signal u8 component is passed via the val
> + *			parameter.
> + * @device_u32_write	Device u32 component write callback. The write value of
> + *			the respective Device u32 component is passed via the
> + *			val parameter.
> + * @count_u32_write	Count u32 component write callback. The write value of
> + *			the respective Count u32 component is passed via the val
> + *			parameter.
> + * @signal_u32_write	Signal u32 component write callback. The write value of
> + *			the respective Signal u32 component is passed via the
> + *			val parameter.
> + * @device_u64_write	Device u64 component write callback. The write value of
> + *			the respective Device u64 component is passed via the
> + *			val parameter.
> + * @count_u64_write	Count u64 component write callback. The write value of
> + *			the respective Count u64 component is passed via the val
> + *			parameter.
> + * @signal_u64_write	Signal u64 component write callback. The write value of
> + *			the respective Signal u64 component is passed via the
> + *			val parameter.
>   */
> -struct counter_signal_ext {
> +struct counter_comp {
> +	enum counter_comp_type type;
>  	const char *name;
> -	ssize_t (*read)(struct counter_device *counter,
> -			struct counter_signal *signal, void *priv, char *buf);
> -	ssize_t (*write)(struct counter_device *counter,
> -			 struct counter_signal *signal, void *priv,
> -			 const char *buf, size_t len);
>  	void *priv;
> +	union {
> +		int (*action_read)(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   struct counter_synapse *synapse,
> +				   enum counter_synapse_action *action);
> +		int (*device_u8_read)(struct counter_device *counter, u8 *val);
> +		int (*count_u8_read)(struct counter_device *counter,
> +				     struct counter_count *count, u8 *val);
> +		int (*signal_u8_read)(struct counter_device *counter,
> +				      struct counter_signal *signal, u8 *val);
> +		int (*device_u32_read)(struct counter_device *counter,
> +				       u32 *val);
> +		int (*count_u32_read)(struct counter_device *counter,
> +				      struct counter_count *count, u32 *val);
> +		int (*signal_u32_read)(struct counter_device *counter,
> +				       struct counter_signal *signal, u32 *val);
> +		int (*device_u64_read)(struct counter_device *counter,
> +				       u64 *val);
> +		int (*count_u64_read)(struct counter_device *counter,
> +				      struct counter_count *count, u64 *val);
> +		int (*signal_u64_read)(struct counter_device *counter,
> +				       struct counter_signal *signal, u64 *val);
> +	};
> +	union {
> +		int (*action_write)(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    struct counter_synapse *synapse,
> +				    enum counter_synapse_action action);
> +		int (*device_u8_write)(struct counter_device *counter, u8 val);
> +		int (*count_u8_write)(struct counter_device *counter,
> +				      struct counter_count *count, u8 val);
> +		int (*signal_u8_write)(struct counter_device *counter,
> +				       struct counter_signal *signal, u8 val);
> +		int (*device_u32_write)(struct counter_device *counter,
> +					u32 val);
> +		int (*count_u32_write)(struct counter_device *counter,
> +				       struct counter_count *count, u32 val);
> +		int (*signal_u32_write)(struct counter_device *counter,
> +					struct counter_signal *signal, u32 val);
> +		int (*device_u64_write)(struct counter_device *counter,
> +					u64 val);
> +		int (*count_u64_write)(struct counter_device *counter,
> +				       struct counter_count *count, u64 val);
> +		int (*signal_u64_write)(struct counter_device *counter,
> +					struct counter_signal *signal, u64 val);
> +	};
>  };
>  
>  /**
>   * struct counter_signal - Counter Signal node
> - * @id:		unique ID used to identify signal
> - * @name:	device-specific Signal name; ideally, this should match the name
> - *		as it appears in the datasheet documentation
> - * @ext:	optional array of Counter Signal extensions
> - * @num_ext:	number of Counter Signal extensions specified in @ext
> - * @priv:	optional private data supplied by driver
> + * @id:		unique ID used to identify the Signal
> + * @name:	device-specific Signal name
> + * @ext:	optional array of Signal extensions
> + * @num_ext:	number of Signal extensions specified in @ext
>   */
>  struct counter_signal {
>  	int id;
>  	const char *name;
>  
> -	const struct counter_signal_ext *ext;
> +	struct counter_comp *ext;
>  	size_t num_ext;
> -
> -	void *priv;
> -};
> -
> -/**
> - * struct counter_signal_enum_ext - Signal enum extension attribute
> - * @items:	Array of strings
> - * @num_items:	Number of items specified in @items
> - * @set:	Set callback function; may be NULL
> - * @get:	Get callback function; may be NULL
> - *
> - * The counter_signal_enum_ext structure can be used to implement enum style
> - * Signal extension attributes. Enum style attributes are those which have a set
> - * of strings that map to unsigned integer values. The Generic Counter Signal
> - * enum extension helper code takes care of mapping between value and string, as
> - * well as generating a "_available" file which contains a list of all available
> - * items. The get callback is used to query the currently active item; the index
> - * of the item within the respective items array is returned via the 'item'
> - * parameter. The set callback is called when the attribute is updated; the
> - * 'item' parameter contains the index of the newly activated item within the
> - * respective items array.
> - */
> -struct counter_signal_enum_ext {
> -	const char * const *items;
> -	size_t num_items;
> -	int (*get)(struct counter_device *counter,
> -		   struct counter_signal *signal, size_t *item);
> -	int (*set)(struct counter_device *counter,
> -		   struct counter_signal *signal, size_t item);
> -};
> -
> -/**
> - * COUNTER_SIGNAL_ENUM() - Initialize Signal enum extension
> - * @_name:	Attribute name
> - * @_e:		Pointer to a counter_signal_enum_ext structure
> - *
> - * This should usually be used together with COUNTER_SIGNAL_ENUM_AVAILABLE()
> - */
> -#define COUNTER_SIGNAL_ENUM(_name, _e) \
> -{ \
> -	.name = (_name), \
> -	.read = counter_signal_enum_read, \
> -	.write = counter_signal_enum_write, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * COUNTER_SIGNAL_ENUM_AVAILABLE() - Initialize Signal enum available extension
> - * @_name:	Attribute name ("_available" will be appended to the name)
> - * @_e:		Pointer to a counter_signal_enum_ext structure
> - *
> - * Creates a read only attribute that lists all the available enum items in a
> - * newline separated list. This should usually be used together with
> - * COUNTER_SIGNAL_ENUM()
> - */
> -#define COUNTER_SIGNAL_ENUM_AVAILABLE(_name, _e) \
> -{ \
> -	.name = (_name "_available"), \
> -	.read = counter_signal_enum_available_read, \
> -	.priv = (_e) \
> -}
> -
> -enum counter_synapse_action {
> -	COUNTER_SYNAPSE_ACTION_NONE = 0,
> -	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> -	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> -	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
>  };
>  
>  /**
>   * struct counter_synapse - Counter Synapse node
> - * @action:		index of current action mode
>   * @actions_list:	array of available action modes
>   * @num_actions:	number of action modes specified in @actions_list
> - * @signal:		pointer to associated signal
> + * @signal:		pointer to the associated Signal

Might have been nice to pull the cases that were purely capitalization out as
a separate patch immediately following this one. There aren't
a huge number, but from a review point of view it's a noop patch
so doesn't need the reviewer to be awake :)

>   */
>  struct counter_synapse {
> -	size_t action;
>  	const enum counter_synapse_action *actions_list;
>  	size_t num_actions;
>  
>  	struct counter_signal *signal;
>  };
>  
> -struct counter_count;
> -
> -/**
> - * struct counter_count_ext - Counter Count extension
> - * @name:	attribute name
> - * @read:	read callback for this attribute; may be NULL
> - * @write:	write callback for this attribute; may be NULL
> - * @priv:	data private to the driver
> - */
> -struct counter_count_ext {
> -	const char *name;
> -	ssize_t (*read)(struct counter_device *counter,
> -			struct counter_count *count, void *priv, char *buf);
> -	ssize_t (*write)(struct counter_device *counter,
> -			 struct counter_count *count, void *priv,
> -			 const char *buf, size_t len);
> -	void *priv;
> -};
> -
> -enum counter_count_function {
> -	COUNTER_COUNT_FUNCTION_INCREASE = 0,
> -	COUNTER_COUNT_FUNCTION_DECREASE,
> -	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> -};
> -
>  /**
>   * struct counter_count - Counter Count node
> - * @id:			unique ID used to identify Count
> - * @name:		device-specific Count name; ideally, this should match
> - *			the name as it appears in the datasheet documentation
> - * @function:		index of current function mode
> - * @functions_list:	array available function modes
> + * @id:			unique ID used to identify the Count
> + * @name:		device-specific Count name
> + * @functions_list:	array of available function modes
>   * @num_functions:	number of function modes specified in @functions_list
> - * @synapses:		array of synapses for initialization
> - * @num_synapses:	number of synapses specified in @synapses
> - * @ext:		optional array of Counter Count extensions
> - * @num_ext:		number of Counter Count extensions specified in @ext
> - * @priv:		optional private data supplied by driver
> + * @synapses:		array of Synapses for initialization
> + * @num_synapses:	number of Synapses specified in @synapses
> + * @ext:		optional array of Count extensions
> + * @num_ext:		number of Count extensions specified in @ext
>   */
>  struct counter_count {
>  	int id;
>  	const char *name;
>  
> -	size_t function;
> -	const enum counter_count_function *functions_list;
> +	const enum counter_function *functions_list;
>  	size_t num_functions;
>  
>  	struct counter_synapse *synapses;
>  	size_t num_synapses;
>  
> -	const struct counter_count_ext *ext;
> +	struct counter_comp *ext;
>  	size_t num_ext;
> -
> -	void *priv;
> -};
> -
> -/**
> - * struct counter_count_enum_ext - Count enum extension attribute
> - * @items:	Array of strings
> - * @num_items:	Number of items specified in @items
> - * @set:	Set callback function; may be NULL
> - * @get:	Get callback function; may be NULL
> - *
> - * The counter_count_enum_ext structure can be used to implement enum style
> - * Count extension attributes. Enum style attributes are those which have a set
> - * of strings that map to unsigned integer values. The Generic Counter Count
> - * enum extension helper code takes care of mapping between value and string, as
> - * well as generating a "_available" file which contains a list of all available
> - * items. The get callback is used to query the currently active item; the index
> - * of the item within the respective items array is returned via the 'item'
> - * parameter. The set callback is called when the attribute is updated; the
> - * 'item' parameter contains the index of the newly activated item within the
> - * respective items array.
> - */
> -struct counter_count_enum_ext {
> -	const char * const *items;
> -	size_t num_items;
> -	int (*get)(struct counter_device *counter, struct counter_count *count,
> -		   size_t *item);
> -	int (*set)(struct counter_device *counter, struct counter_count *count,
> -		   size_t item);
> -};
> -
> -/**
> - * COUNTER_COUNT_ENUM() - Initialize Count enum extension
> - * @_name:	Attribute name
> - * @_e:		Pointer to a counter_count_enum_ext structure
> - *
> - * This should usually be used together with COUNTER_COUNT_ENUM_AVAILABLE()
> - */
> -#define COUNTER_COUNT_ENUM(_name, _e) \
> -{ \
> -	.name = (_name), \
> -	.read = counter_count_enum_read, \
> -	.write = counter_count_enum_write, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * COUNTER_COUNT_ENUM_AVAILABLE() - Initialize Count enum available extension
> - * @_name:	Attribute name ("_available" will be appended to the name)
> - * @_e:		Pointer to a counter_count_enum_ext structure
> - *
> - * Creates a read only attribute that lists all the available enum items in a
> - * newline separated list. This should usually be used together with
> - * COUNTER_COUNT_ENUM()
> - */
> -#define COUNTER_COUNT_ENUM_AVAILABLE(_name, _e) \
> -{ \
> -	.name = (_name "_available"), \
> -	.read = counter_count_enum_available_read, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * struct counter_device_attr_group - internal container for attribute group
> - * @attr_group:	Counter sysfs attributes group
> - * @attr_list:	list to keep track of created Counter sysfs attributes
> - * @num_attr:	number of Counter sysfs attributes
> - */
> -struct counter_device_attr_group {
> -	struct attribute_group attr_group;
> -	struct list_head attr_list;
> -	size_t num_attr;
> -};
> -
> -/**
> - * struct counter_device_state - internal state container for a Counter device
> - * @id:			unique ID used to identify the Counter
> - * @dev:		internal device structure
> - * @groups_list:	attribute groups list (for Signals, Counts, and ext)
> - * @num_groups:		number of attribute groups containers
> - * @groups:		Counter sysfs attribute groups (to populate @dev.groups)
> - */
> -struct counter_device_state {
> -	int id;
> -	struct device dev;
> -	struct counter_device_attr_group *groups_list;
> -	size_t num_groups;
> -	const struct attribute_group **groups;
> -};
> -
> -enum counter_signal_value {
> -	COUNTER_SIGNAL_LOW = 0,
> -	COUNTER_SIGNAL_HIGH
>  };
>  
>  /**
>   * struct counter_ops - Callbacks from driver
> - * @signal_read:	optional read callback for Signal attribute. The read
> - *			value of the respective Signal should be passed back via
> - *			the val parameter.
> - * @count_read:		optional read callback for Count attribute. The read
> - *			value of the respective Count should be passed back via
> - *			the val parameter.
> - * @count_write:	optional write callback for Count attribute. The write
> - *			value for the respective Count is passed in via the val
> + * @signal_read:	read callback for Signals. The read level of the
> + *			respective Signal should be passed back via the level
>   *			parameter.
> - * @function_get:	function to get the current count function mode. Returns
> - *			0 on success and negative error code on error. The index
> - *			of the respective Count's returned function mode should
> - *			be passed back via the function parameter.
> - * @function_set:	function to set the count function mode. function is the
> - *			index of the requested function mode from the respective
> - *			Count's functions_list array.
> - * @action_get:		function to get the current action mode. Returns 0 on
> - *			success and negative error code on error. The index of
> - *			the respective Synapse's returned action mode should be
> - *			passed back via the action parameter.
> - * @action_set:		function to set the action mode. action is the index of
> - *			the requested action mode from the respective Synapse's
> - *			actions_list array.
> + * @count_read:		read callback for Counts. The read value of the
> + *			respective Count should be passed back via the value
> + *			parameter.
> + * @count_write:	write callback for Counts. The write value for the
> + *			respective Count is passed in via the value parameter.
> + * @function_read:	read callback the Count function modes. The read
> + *			function mode of the respective Count should be passed
> + *			back via the function parameter.
> + * @function_write:	write callback for Count function modes. The function
> + *			mode to write for the respective Count is passed in via
> + *			the function parameter.
> + * @action_read:	read callback the Synapse action modes. The read action
> + *			mode of the respective Synapse should be passed back via
> + *			the action parameter.
> + * @action_write:	write callback for Synapse action modes. The action mode
> + *			to write for the respective Synapse is passed in via the
> + *			action parameter.
>   */
>  struct counter_ops {
>  	int (*signal_read)(struct counter_device *counter,
>  			   struct counter_signal *signal,
> -			   enum counter_signal_value *val);
> +			   enum counter_signal_level *level);
>  	int (*count_read)(struct counter_device *counter,
> -			  struct counter_count *count, unsigned long *val);
> +			  struct counter_count *count, u64 *value);
>  	int (*count_write)(struct counter_device *counter,
> -			   struct counter_count *count, unsigned long val);
> -	int (*function_get)(struct counter_device *counter,
> -			    struct counter_count *count, size_t *function);
> -	int (*function_set)(struct counter_device *counter,
> -			    struct counter_count *count, size_t function);
> -	int (*action_get)(struct counter_device *counter,
> -			  struct counter_count *count,
> -			  struct counter_synapse *synapse, size_t *action);
> -	int (*action_set)(struct counter_device *counter,
> -			  struct counter_count *count,
> -			  struct counter_synapse *synapse, size_t action);
> +			   struct counter_count *count, u64 value);
> +	int (*function_read)(struct counter_device *counter,
> +			     struct counter_count *count,
> +			     enum counter_function *function);
> +	int (*function_write)(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      enum counter_function function);
> +	int (*action_read)(struct counter_device *counter,
> +			   struct counter_count *count,
> +			   struct counter_synapse *synapse,
> +			   enum counter_synapse_action *action);
> +	int (*action_write)(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    struct counter_synapse *synapse,
> +			    enum counter_synapse_action action);
>  };
>  
> -/**
> - * struct counter_device_ext - Counter device extension
> - * @name:	attribute name
> - * @read:	read callback for this attribute; may be NULL
> - * @write:	write callback for this attribute; may be NULL
> - * @priv:	data private to the driver
> - */
> -struct counter_device_ext {
> -	const char *name;
> -	ssize_t (*read)(struct counter_device *counter, void *priv, char *buf);
> -	ssize_t (*write)(struct counter_device *counter, void *priv,
> -			 const char *buf, size_t len);
> -	void *priv;
> -};
> -
> -/**
> - * struct counter_device_enum_ext - Counter enum extension attribute
> - * @items:	Array of strings
> - * @num_items:	Number of items specified in @items
> - * @set:	Set callback function; may be NULL
> - * @get:	Get callback function; may be NULL
> - *
> - * The counter_device_enum_ext structure can be used to implement enum style
> - * Counter extension attributes. Enum style attributes are those which have a
> - * set of strings that map to unsigned integer values. The Generic Counter enum
> - * extension helper code takes care of mapping between value and string, as well
> - * as generating a "_available" file which contains a list of all available
> - * items. The get callback is used to query the currently active item; the index
> - * of the item within the respective items array is returned via the 'item'
> - * parameter. The set callback is called when the attribute is updated; the
> - * 'item' parameter contains the index of the newly activated item within the
> - * respective items array.
> - */
> -struct counter_device_enum_ext {
> -	const char * const *items;
> -	size_t num_items;
> -	int (*get)(struct counter_device *counter, size_t *item);
> -	int (*set)(struct counter_device *counter, size_t item);
> -};
> -
> -/**
> - * COUNTER_DEVICE_ENUM() - Initialize Counter enum extension
> - * @_name:	Attribute name
> - * @_e:		Pointer to a counter_device_enum_ext structure
> - *
> - * This should usually be used together with COUNTER_DEVICE_ENUM_AVAILABLE()
> - */
> -#define COUNTER_DEVICE_ENUM(_name, _e) \
> -{ \
> -	.name = (_name), \
> -	.read = counter_device_enum_read, \
> -	.write = counter_device_enum_write, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * COUNTER_DEVICE_ENUM_AVAILABLE() - Initialize Counter enum available extension
> - * @_name:	Attribute name ("_available" will be appended to the name)
> - * @_e:		Pointer to a counter_device_enum_ext structure
> - *
> - * Creates a read only attribute that lists all the available enum items in a
> - * newline separated list. This should usually be used together with
> - * COUNTER_DEVICE_ENUM()
> - */
> -#define COUNTER_DEVICE_ENUM_AVAILABLE(_name, _e) \
> -{ \
> -	.name = (_name "_available"), \
> -	.read = counter_device_enum_available_read, \
> -	.priv = (_e) \
> -}
> -
>  /**
>   * struct counter_device - Counter data structure
> - * @name:		name of the device as it appears in the datasheet
> + * @name:		name of the device
>   * @parent:		optional parent device providing the counters
> - * @device_state:	internal device state container
>   * @ops:		callbacks from driver
>   * @signals:		array of Signals
>   * @num_signals:	number of Signals specified in @signals
> @@ -425,11 +298,12 @@ struct counter_device_enum_ext {
>   * @ext:		optional array of Counter device extensions
>   * @num_ext:		number of Counter device extensions specified in @ext
>   * @priv:		optional private data supplied by driver
> + * @id:			unique ID used to identify the Counter
> + * @dev:		internal device structure
>   */
>  struct counter_device {
>  	const char *name;
>  	struct device *parent;
> -	struct counter_device_state *device_state;
>  
>  	const struct counter_ops *ops;
>  
> @@ -438,17 +312,160 @@ struct counter_device {
>  	struct counter_count *counts;
>  	size_t num_counts;
>  
> -	const struct counter_device_ext *ext;
> +	struct counter_comp *ext;
>  	size_t num_ext;
>  
>  	void *priv;
> +
> +	int id;
> +	struct device dev;
>  };
>  
>  int counter_register(struct counter_device *const counter);
>  void counter_unregister(struct counter_device *const counter);
>  int devm_counter_register(struct device *dev,
>  			  struct counter_device *const counter);
> -void devm_counter_unregister(struct device *dev,
> -			     struct counter_device *const counter);
> +
> +#define COUNTER_COMP_DEVICE_U8(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U8, \
> +	.name = (_name), \
> +	.device_u8_read = (_read), \
> +	.device_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_COUNT_U8(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U8, \
> +	.name = (_name), \
> +	.count_u8_read = (_read), \
> +	.count_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_SIGNAL_U8(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U8, \
> +	.name = (_name), \
> +	.signal_u8_read = (_read), \
> +	.signal_u8_write = (_write), \
> +}
> +
> +#define COUNTER_COMP_DEVICE_U64(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U64, \
> +	.name = (_name), \
> +	.device_u64_read = (_read), \
> +	.device_u64_write = (_write), \
> +}
> +#define COUNTER_COMP_COUNT_U64(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U64, \
> +	.name = (_name), \
> +	.count_u64_read = (_read), \
> +	.count_u64_write = (_write), \
> +}
> +#define COUNTER_COMP_SIGNAL_U64(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U64, \
> +	.name = (_name), \
> +	.signal_u64_read = (_read), \
> +	.signal_u64_write = (_write), \
> +}
> +
> +#define COUNTER_COMP_DEVICE_BOOL(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_BOOL, \
> +	.name = (_name), \
> +	.device_u8_read = (_read), \
> +	.device_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_COUNT_BOOL(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_BOOL, \
> +	.name = (_name), \
> +	.count_u8_read = (_read), \
> +	.count_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_SIGNAL_BOOL(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_BOOL, \
> +	.name = (_name), \
> +	.signal_u8_read = (_read), \
> +	.signal_u8_write = (_write), \
> +}
> +
> +struct counter_available {
> +	union {
> +		const u32 *enums;
> +		const char *const *strs;
> +	};
> +	size_t num_items;
> +};
> +
> +#define DEFINE_COUNTER_AVAILABLE(_name, _enums) \
> +	struct counter_available _name = { \
> +		.enums = (_enums), \
> +		.num_items = ARRAY_SIZE(_enums), \
> +	}
> +
> +#define DEFINE_COUNTER_ENUM(_name, _strs) \
> +	struct counter_available _name = { \
> +		.strs = (_strs), \
> +		.num_items = ARRAY_SIZE(_strs), \
> +	}
> +
> +#define COUNTER_COMP_DEVICE_ENUM(_name, _get, _set, _available) \
> +{ \
> +	.type = COUNTER_COMP_ENUM, \
> +	.name = (_name), \
> +	.device_u32_read = (_get), \
> +	.device_u32_write = (_set), \
> +	.priv = &(_available), \
> +}
> +#define COUNTER_COMP_COUNT_ENUM(_name, _get, _set, _available) \
> +{ \
> +	.type = COUNTER_COMP_ENUM, \
> +	.name = (_name), \
> +	.count_u32_read = (_get), \
> +	.count_u32_write = (_set), \
> +	.priv = &(_available), \
> +}
> +#define COUNTER_COMP_SIGNAL_ENUM(_name, _get, _set, _available) \
> +{ \
> +	.type = COUNTER_COMP_ENUM, \
> +	.name = (_name), \
> +	.signal_u32_read = (_get), \
> +	.signal_u32_write = (_set), \
> +	.priv = &(_available), \
> +}
> +
> +#define COUNTER_COMP_CEILING(_read, _write) \
> +	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
> +
> +#define COUNTER_COMP_COUNT_MODE(_read, _write, _available) \
> +{ \
> +	.type = COUNTER_COMP_COUNT_MODE, \
> +	.name = "count_mode", \
> +	.count_u32_read = (_read), \
> +	.count_u32_write = (_write), \
> +	.priv = &(_available), \
> +}
> +
> +#define COUNTER_COMP_DIRECTION(_read) \
> +{ \
> +	.type = COUNTER_COMP_COUNT_DIRECTION, \
> +	.name = "direction", \
> +	.count_u32_read = (_read), \
> +}
> +
> +#define COUNTER_COMP_ENABLE(_read, _write) \
> +	COUNTER_COMP_COUNT_BOOL("enable", _read, _write)
> +
> +#define COUNTER_COMP_FLOOR(_read, _write) \
> +	COUNTER_COMP_COUNT_U64("floor", _read, _write)
> +
> +#define COUNTER_COMP_PRESET(_read, _write) \
> +	COUNTER_COMP_COUNT_U64("preset", _read, _write)
> +
> +#define COUNTER_COMP_PRESET_ENABLE(_read, _write) \
> +	COUNTER_COMP_COUNT_BOOL("preset_enable", _read, _write)
>  
>  #endif /* _COUNTER_H_ */
...

